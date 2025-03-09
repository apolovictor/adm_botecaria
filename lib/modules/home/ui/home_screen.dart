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
