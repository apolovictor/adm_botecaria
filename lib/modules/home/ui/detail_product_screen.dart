import 'package:adm_botecaria/modules/home/ui/widgets/barcode.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/chip_widget.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/detail_manufacturer_card_image.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/helpers/validators.dart';
import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../helpers/helpers.dart';
import '../providers/states/detail_product_states.dart';
import 'components/auto_save/auto_save_component.dart';
import 'components/buttons/update_button.dart';
import 'widgets/detail_product_card_image.dart';
import 'widgets/text_field_widget.dart';

class DetailProductPage extends StatelessWidget with HookMixin {
  const DetailProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedProduct = useAtomState(selectedProductAtom);
    final detailProductState = useAtomState(detailProductStateAtom);
    final selectedImage = useAtomState(selectedImageOfDetailProductState);

    final width = MediaQuery.sizeOf(context).width;

    final NCMString = selectedProduct?.NCM?.toString();
    final CESTString =
        selectedProduct?.CEST != null
            ? selectedProduct?.CEST.toString().length == 6
                ? '0${selectedProduct?.CEST}'
                : selectedProduct?.CEST.toString()
            : null;

    final detailProductPrecoMedioUnitario = useAtomState(
      detailProductPrecoMedioUnitarioAtom,
    );
    final detailProductPrecoMedioVenda = useAtomState(
      detailProductPrecoMedioVendaAtom,
    );

    return selectedProduct != null
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                detailProductState is! DetailProductStatesLoading
                    ? SizedBox(
                      child:
                          selectedProduct.imageUrl != null
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Stack(
                                      children: [
                                        Hero(
                                          tag: selectedProduct.documentId!,
                                          child: DetailProductCardImage(
                                            product: selectedProduct,
                                          ),
                                        ),
                                        // Positioned(
                                        //   bottom: 0,
                                        //   right: 0,
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       IconButton(
                                        //         icon: Icon(
                                        //           Icons.delete,
                                        //           size: 30,
                                        //           color: Colors.grey.shade500,
                                        //         ),
                                        //         onPressed: () async {
                                        //           // await removeImageOfProductAction(
                                        //           //   widget.product,
                                        //           // );
                                        //         },
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              : selectedImage != null
                              ? Hero(
                                tag: selectedProduct.documentId!,
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: ClipOval(
                                            child: Image.memory(
                                              selectedImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: AutoSaveComponent(
                                          product: selectedProduct,
                                          selectedImage: selectedImage,
                                        ),
                                        // IconButton(
                                        //   icon: Icon(
                                        //     Icons.delete,
                                        //     size: 30,
                                        //     color: Colors.grey.shade900,
                                        //   ),
                                        //   onPressed:
                                        //       clearDetailProductImageAction.call,
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Colors.grey],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    (width) * 0.3,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black45,
                                      offset: Offset(4, 4),
                                      blurRadius: 2,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-4, -4),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    MaterialButton(
                                      shape: const CircleBorder(),
                                      onPressed: () async {
                                        await getGalleryImageOfDetailProudct(
                                          250,
                                          250,
                                        );
                                      },
                                      child: Center(
                                        child:
                                            selectedImage != null &&
                                                    selectedImage.isNotEmpty
                                                ? ClipOval(
                                                  child: Image.memory(
                                                    selectedImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                                : Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: width * 0.3 / 2,
                                                ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    )
                    : Center(child: CircularProgressIndicator()),
                SizedBox(height: 10),
                Text(selectedProduct.cProd, textAlign: TextAlign.center),
                SizedBox(height: 5),
                Text(
                  'Nome na NFC-e: ${selectedProduct.xProd}',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                selectedProduct.cEAN != null
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildBarcode(
                          selectedProduct.cEAN.toString(),
                          width: width,
                          height: 60,
                          // selectedProduct.cEAN.toString().length == 13
                          //     ? Barcode.ean13(drawEndChar: true)
                          //     : Barcode.ean8(),
                          // selectedProduct.cEAN.toString(),
                        ),
                      ],
                    )
                    : SizedBox(),
                SizedBox(height: 10),

                NCMString != null
                    ? Row(
                      children: [
                        Text(
                          'NCM: ${NCMString.substring(0, 4)}.${NCMString.substring(4, 6)}.${NCMString.substring(6, 8)}',
                        ),
                      ],
                    )
                    : SizedBox(),
                CESTString != null
                    ? Row(
                      children: [
                        Text(
                          'CEST: ${CESTString.substring(0, 2)}.${CESTString.substring(2, 5)}.${CESTString.substring(5, 7)}',
                        ),
                      ],
                    )
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('GPC', style: TextStyle(fontSize: 16))],
                      ),
                      SizedBox(height: 5),

                      Text('Segmento: Comidas e Bebidas'),
                      Text('Família: ${selectedProduct.gpcFamilyDescription}'),
                      Text('Class: ${selectedProduct.gpcClassDescription}'),
                      Text('Bloco: ${selectedProduct.gpcBrickDescription}'),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Text('Categoria: ${selectedProduct.categoryName}'),
                  ],
                ),
                Row(
                  children: [
                    Text('Unidade Comercial: ${selectedProduct.uCom}'),
                  ],
                ),
                SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fabricante: ${selectedProduct.manufacturerBrand}',
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: DetailManufacturerCardImage(
                          product: selectedProduct,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    selectedProduct.precoMedioUnitario != null &&
                            selectedProduct.precoMedioUnitario! > 0
                        ? ChipWidget(
                          labelColor:
                              Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer,
                          backgorundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          value: selectedProduct.precoMedioUnitario!,
                          iconData: Icons.input,
                        )
                        : SizedBox(
                          width: width * 0.4,
                          child: getTextField(
                            labelText: 'Preço médio unitário (Interno)',
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                            // focusNodeCurrent: focusNodes[7],
                            // onFieldSubmitted:
                            //     (_) => FocusScope.of(context).requestFocus(focusNodes[8]),
                            onChanged: (value) {
                              String cleanedValue = value
                                  .replaceAll('R\$', '')
                                  .replaceAll('.', '');
                              updateProductAverageUnitPriceAction(cleanedValue);
                            },
                          ),
                        ),

                    selectedProduct.precoMedioVenda != null &&
                            selectedProduct.precoMedioVenda! > 0
                        ? ChipWidget(
                          labelColor:
                              Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer,
                          backgorundColor: Color(0xFFcdeda3),
                          value: selectedProduct.precoMedioVenda!,
                          iconData: Icons.arrow_outward,
                        )
                        : SizedBox(
                          width: width * 0.4,
                          child: getTextField(
                            labelText: 'Preço médio venda (Interno)',
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                            // focusNodeCurrent: focusNodes[7],
                            // onFieldSubmitted:
                            //     (_) => FocusScope.of(context).requestFocus(focusNodes[8]),
                            onChanged: (value) {
                              String cleanedValue = value
                                  .replaceAll('R\$', '')
                                  .replaceAll('.', '');
                              updateProductAverageSellPriceAction(cleanedValue);
                            },
                          ),
                        ),
                  ],
                ),
                SizedBox(height: 10),

                selectedProduct.precoMedioUnitario.toString() !=
                                detailProductPrecoMedioUnitario &&
                            detailProductPrecoMedioUnitario.isNotEmpty &&
                            double.parse(
                                  detailProductPrecoMedioUnitario.replaceAll(
                                    ',',
                                    '.',
                                  ),
                                ) >
                                0 ||
                        selectedProduct.precoMedioVenda.toString() !=
                                detailProductPrecoMedioVenda &&
                            detailProductPrecoMedioVenda.isNotEmpty &&
                            double.parse(
                                  detailProductPrecoMedioVenda.replaceAll(
                                    ',',
                                    '.',
                                  ),
                                ) >
                                0
                    ? UpdateButton(
                      widgetText: Text(
                        'Atualizar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onpressed: () {},
                    )
                    : SizedBox(),
              ],
            ),
          ),
        )
        : SizedBox();
  }
}
