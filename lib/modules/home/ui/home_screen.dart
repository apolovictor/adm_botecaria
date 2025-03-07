import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/product_card.dart';
import 'package:adm_botecaria/shared/utils/const.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../asp/selectors.dart';
import '../providers/states/product_states.dart';

class HomePage extends StatelessWidget with HookMixin {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setProductStateAction(ProductStatusStateInitial());
    });
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    useAtomState(getAdmProductsSelector);

    final List<Product> productList = useAtomState(productListAtom);
    final selectedCard = useAtomState(selectedCardAtom);

    final result =
        productList
            .where(
              (e) => e.completionPercentage == (selectedCard / requiredFields),
            )
            .toList();

    result.sort((a, b) => a.cProd.compareTo(b.cProd));

    List<Widget> generateCardGoals() =>
        List.generate(
          requiredFields,
          (index) =>
              (index + 1) != 14
                  ? InkWell(
                    onTap: () => setSelectedCardAction(index + 1),
                    child: SizedBox(
                      height: height * 0.15,
                      width: width * 0.35,
                      child: Card(
                        elevation: selectedCard == (index + 1) ? 0 : 5,
                        child: Center(
                          child: CircularPercentIndicator(
                            percent: index / requiredFields,
                            index: index + 1,
                          ),
                          // Text('${index + 1}/14')
                        ),
                      ),
                    ),
                  )
                  : SizedBox(),
        ).reversed.toList();

    List<Widget> generateCardProducts(List<Product> products) =>
        List.generate(
          products.length,
          (index) => ProductCard(
            height: height,
            width: width,
            product: products[index],
          ),
        ).toList();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: [
              ...generateCardGoals(),
              SizedBox(
                height: height * 0.15,
                width: width * 0.35,
                child: Card(
                  elevation: 5,
                  child: Center(
                    child: CircularPercentIndicator(index: 14, percent: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          child: Column(
            children: [
              ...generateCardProducts(result),
              // list the products accordiging your percent progress
            ],
          ),
        ),
      ],
    );
  }
}

class CircularPercentIndicator extends StatefulWidget {
  final double percent;
  final double radius;
  final double lineWidth;
  final Color fillColor;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle percentTextStyle;
  final Duration animationDuration;
  final int index;

  const CircularPercentIndicator({
    super.key,
    required this.percent,
    required this.index,
    this.radius = 30.0,
    this.lineWidth = 8.0,
    this.fillColor = Colors.transparent,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.indigo,
    this.percentTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
    this.animationDuration = const Duration(milliseconds: 1000),
  }) : assert(percent >= 0 && percent <= 1);

  @override
  CircularPercentIndicatorState createState() =>
      CircularPercentIndicatorState();
}

class CircularPercentIndicatorState extends State<CircularPercentIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularPercentPainter(
        percent: widget.percent,
        lineWidth: widget.lineWidth,
        fillColor: widget.fillColor,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.lineWidth / 2),
        child: SizedBox(
          height: widget.radius * 2,
          width: widget.radius * 2,
          child: Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  '${(widget.index * _animation.value).toStringAsFixed(0)}/${(requiredFields * _animation.value).toStringAsFixed(0)}',
                  style: widget.percentTextStyle,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularPercentPainter extends CustomPainter {
  final double percent;
  final double lineWidth;
  final Color fillColor;
  final Color backgroundColor;
  final Color progressColor;

  _CircularPercentPainter({
    required this.percent,
    required this.lineWidth,
    required this.fillColor,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - lineWidth) / 2;

    // Background circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth,
    );

    // Filled circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );

    // Arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      radians(-90), // Start at -90 degrees (top)
      radians(360.0 * percent), // Sweep angle based on percent
      false, // Don't use center
      Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = StrokeCap.round, // Round ends similar to your image
    );
  }

  @override
  bool shouldRepaint(covariant _CircularPercentPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}
