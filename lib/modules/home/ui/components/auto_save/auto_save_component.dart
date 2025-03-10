import 'dart:async';
import 'dart:typed_data';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../../asp/actions.dart';
import '../../../models/products_model.dart';

class AutoSaveComponent extends StatefulWidget {
  const AutoSaveComponent({
    super.key,
    required this.product,
    required this.selectedImage,
  });

  final Product product;
  final Uint8List selectedImage;

  @override
  State<AutoSaveComponent> createState() => _AutoSaveComponentState();
}

class _AutoSaveComponentState extends State<AutoSaveComponent>
    with SingleTickerProviderStateMixin, HookStateMixin {
  late int? counter;
  Timer? timer = Timer(Duration.zero, () {});
  late AnimationController _animationController;
  late Animation<double> _doubleAnimation;

  @override
  void initState() {
    counter = 5;
    if (counter != null) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          counter = counter! - 1;
        });
        if (counter == 0) {
          updateImageOfProductAction(widget.product, widget.selectedImage);
          clearDetailProductImageAction.call();

          timer.cancel();
        }
      });
    }
    _animationController = AnimationController(
      duration: const Duration(seconds: 5), // Match the timer duration
      vsync: this, // Required for animation
    );

    _doubleAnimation = Tween<double>(
      begin: 1.0, // Start color (right side)
      end: 0.0, // End color (left side)
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedButtonTemplate(
      buttonText: 'Cancelar',
      doubleAnimation: _doubleAnimation,
      width: 200,
    );
  }
}

class RoundedButtonTemplate extends AnimatedWidget {
  const RoundedButtonTemplate({
    super.key,
    required this.buttonText,
    required this.width,
    required Animation<double> doubleAnimation,
  }) : _doubleAnimation = doubleAnimation,
       super(listenable: doubleAnimation);

  final String buttonText;
  final double width;
  final Animation<double> _doubleAnimation;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black87;
    Color color2 = const Color(0xffffffff);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: RoundedMaterialButton(color: color2),
        ),
        ClipRect(
          clipper: RectangleClipper(offset: _doubleAnimation.value * width),
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: color2,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: RoundedMaterialButton(color: color),
          ),
        ),
      ],
    );
  }
}

class RoundedMaterialButton extends StatelessWidget {
  const RoundedMaterialButton({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: clearDetailProductImageAction.call,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Center(
        child: Text(
          'Cancelar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
      ),
    );
  }
}

class RectangleClipper extends CustomClipper<Rect> {
  final double offset;
  RectangleClipper({required this.offset});

  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(size.width, 0.0, offset, size.height);
    return rect;
  }

  @override
  bool shouldReclip(RectangleClipper oldClipper) => true;
}
