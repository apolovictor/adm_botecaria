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
    });
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    useAtomState(getAdmProductsSelector);
    final scrollController = useAtomState(scrollControllerCardGoalsSelector);

    // if (scrollController.hasClients) {
    //   print(scrollController.position.pixels);
    // }
    // selectedCardAtom;
    final List<Product> productList = useAtomState(productListAtom);
    final selectedCard = useAtomState(selectedCardAtom);

    // Function to scroll to the selected card
    void _scrollToSelectedCard(
      ScrollController controller,
      int selectedIndex,
      double cardWidth,
      double screenWidth,
    ) {
      // Calculate the scroll offset based on the selected card's position.

      // Because the list is reversed, we need to calculate the position from the *end*.
      final int itemCount =
          requiredFields; // Total number of items (including 14)

      //The last element is displayed separately. So subtract from itemCount
      int visibleIndex =
          itemCount - 1; //index for items 1 to 13 on reverse order list.
      if (selectedIndex != 14) {
        visibleIndex = itemCount - selectedIndex;
      }

      // Calculate offset considering centering.
      double offset =
          (visibleIndex * cardWidth) - (screenWidth / 1.15 - cardWidth / 2);

      // Keep within bounds of the scrollable area.
      offset = offset.clamp(0.0, controller.position.maxScrollExtent);

      print('visibleIndex ==== $visibleIndex');
      print('offset ==== $offset');

      // Scroll to the calculated offset with animation.
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedCard(scrollController, selectedCard, 125, width);
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
                        child: Center(
                          child: CircularPercentIndicator(
                            percent: index / requiredFields,
                            index: index + 1,
                          ),
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
                    child: Center(
                      child: CircularPercentIndicator(index: 14, percent: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          child: Column(children: [...generateCardProducts(result)]),
        ),
      ],
    );
  }
}
