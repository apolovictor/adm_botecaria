import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/product_card.dart';
import 'package:adm_botecaria/shared/utils/const.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../asp/selectors.dart';
import '../providers/states/product_states.dart';
import 'components/circular_percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget with HookMixin {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setProductStateAction(ProductStatusStateInitial());
      setDetailProductStateInitialAction();
    });
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    useAtomState(getAdmProductsSelector);
    final scrollController = useAtomState(scrollControllerCardGoalsAtom);

    final List<Product> productList = useAtomState(productListAtom);
    final selectedCard = useAtomState(selectedCardAtom);

    // Function to scroll to the selected card
    void scrollToSelectedCard(
      ScrollController controller,
      int selectedIndex,
      double cardWidth,
      double screenWidth,
    ) {
      final int itemCount = requiredFields;

      int visibleIndex = itemCount - 1;
      if (selectedIndex != 14) {
        visibleIndex = itemCount - selectedIndex;
      }

      double offset =
          (visibleIndex * cardWidth) - (screenWidth / 1.15 - cardWidth / 2);

      offset = offset.clamp(0.0, controller.position.maxScrollExtent);

      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToSelectedCard(scrollController, selectedCard, 125, width);
    });

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
                      width: 125,
                      child: Card(
                        elevation: selectedCard == (index + 1) ? 0 : 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              percent: index / requiredFields,
                              index: index + 1,
                            ),
                            Text(
                              'Total ${productList.where((e) => e.completionPercentage == ((index + 1) / requiredFields)).length.toString()}',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
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
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: [
              ...generateCardGoals(),
              InkWell(
                onTap: () => setSelectedCardAction(14),
                child: SizedBox(
                  height: height * 0.15,
                  width: width * 0.35,
                  child: Card(
                    elevation: selectedCard == 14 ? 0 : 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        CircularPercentIndicator(index: 14, percent: 1),
                        Text(
                          'Total ${productList.where((e) => e.completionPercentage == 1).length.toString()}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [...generateCardProducts(result)]),
          ),
        ),
      ],
    );
  }
}
