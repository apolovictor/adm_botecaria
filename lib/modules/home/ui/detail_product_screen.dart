// ignore_for_file: non_constant_identifier_names

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
import 'widgets/update/brand_update_field.dart';
import 'widgets/update/categories_update_field.dart';
import 'widgets/update/gpc_bricks_update_field.dart';
import 'widgets/update/gpc_class_update_field.dart';
import 'widgets/update/gpc_family_update_field.dart';
import 'widgets/update/medidas_update_field.dart';

final _updateFormKey = GlobalKey<FormState>();

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

    final detailProductXProd = useAtomState(detailProductXProdAtom);
    final detailProductEan = useAtomState(detailProductEanAtom);
    final detailProductNCM = useAtomState(detailProductNCMAtom);
    final detailProductCEST = useAtomState(detailProductCESTAtom);
    final detailProductgpcFamilySelected = useAtomState(
      detailProductgpcFamilySelectedAtom,
    );
    final detailProductgpcClassSelected = useAtomState(
      detailProductgpcClassSelectedAtom,
    );
    final detailProductCategory = useAtomState(detailProductCategoryAtom);
    final detailProductUCom = useAtomState(detailProductUComAtom);
    final selectedManufacturer = useAtomState(selectedManufacturersUpdateAtom);

    final detailProductPrecoMedioUnitario = useAtomState(
      detailProductPrecoMedioUnitarioAtom,
    );
    final detailProductPrecoMedioVenda = useAtomState(
      detailProductPrecoMedioVendaAtom,
    );
    final detailProductDescription = useAtomState(detailProductDescriptionAtom);

    return selectedProduct != null
        ? LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: constraints.maxHeight * 2,
                      child: Form(
                        key: _updateFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            detailProductState is! DetailProductStatesLoading
                                ? Hero(
                                  tag: selectedProduct.documentId!,
                                  child: SizedBox(
                                    child:
                                        selectedProduct.imageUrl != null
                                            ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 120,
                                                  width: 120,
                                                  child: Stack(
                                                    children: [
                                                      DetailProductCardImage(
                                                        product:
                                                            selectedProduct,
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
                                            ? SizedBox(
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
                                                      selectedImage:
                                                          selectedImage,
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
                                            )
                                            : Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.grey,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                                          selectedImage !=
                                                                      null &&
                                                                  selectedImage
                                                                      .isNotEmpty
                                                              ? ClipOval(
                                                                child: Image.memory(
                                                                  selectedImage,
                                                                  fit:
                                                                      BoxFit
                                                                          .cover,
                                                                ),
                                                              )
                                                              : Icon(
                                                                Icons.add,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                size:
                                                                    width *
                                                                    0.3 /
                                                                    2,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                  ),
                                )
                                : Center(child: CircularProgressIndicator()),
                            SizedBox(height: 10),
                            Text(
                              selectedProduct.cProd,
                              textAlign: TextAlign.center,
                            ),
                            detailProductState is! DetailProductStatesLoading
                                ? Column(
                                  children: [
                                    selectedProduct.xProd != null
                                        ? Text(
                                          'Nome na NFC-e: ${selectedProduct.xProd}',
                                          textAlign: TextAlign.center,
                                        )
                                        : getTextField(
                                          labelText:
                                              'Nome do Produto que irá na NFC-e',
                                          keyboardType: TextInputType.text,
                                          onChanged:
                                              (value) =>
                                                  value.isEmpty
                                                      ? updateXProdAction(null)
                                                      : updateXProdAction(
                                                        value,
                                                      ),
                                        ),
                                    SizedBox(height: 10),
                                    selectedProduct.cEAN != null
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            buildBarcode(
                                              selectedProduct.cEAN.toString(),
                                              width: width,
                                              height: 60,
                                            ),
                                          ],
                                        )
                                        : getTextField(
                                          labelText: 'GTIN (Código de Barras)',
                                          keyboardType: TextInputType.number,

                                          // focusNodeCurrent: focusNodes[2],
                                          validator: cEan,
                                          // onFieldSubmitted:
                                          //     (_) => FocusScope.of(context).requestFocus(focusNodes[3]),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          onChanged:
                                              (value) => updateEanAction(
                                                int.tryParse(value),
                                              ),
                                        ),
                                    SizedBox(height: 10),

                                    NCMString != null
                                        ? Row(
                                          children: [
                                            Text(
                                              'NCM: ${NCMString.substring(0, 4)}.${NCMString.substring(4, 6)}.${NCMString.substring(6, 8)}',
                                            ),
                                          ],
                                        )
                                        : getTextField(
                                          labelText: 'NCM (8 dígitos)',
                                          keyboardType: TextInputType.number,
                                          validator: validateNCM,

                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],

                                          // focusNodeCurrent: focusNodes[3],
                                          // onFieldSubmitted:
                                          //     (_) => FocusScope.of(context).requestFocus(focusNodes[4]),
                                          onChanged:
                                              (value) => updateNCMAction(
                                                int.tryParse(value),
                                              ),
                                        ),
                                    SizedBox(height: 10),

                                    CESTString != null
                                        ? Row(
                                          children: [
                                            Text(
                                              'CEST: ${CESTString.substring(0, 2)}.${CESTString.substring(2, 5)}.${CESTString.substring(5, 7)}',
                                            ),
                                          ],
                                        )
                                        : getTextField(
                                          labelText: 'CEST',
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          validator: cest,

                                          // focusNodeCurrent: focusNodes[6],
                                          // onFieldSubmitted:
                                          //     (_) => FocusScope.of(context).requestFocus(focusNodes[7]),
                                          onChanged:
                                              (value) => updateCESTAction(
                                                int.tryParse(value),
                                              ),
                                        ),
                                    SizedBox(height: 10),

                                    Container(
                                      padding: EdgeInsets.all(10),
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'GPC',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),

                                          Text('Segmento: Comidas e Bebidas'),
                                          SizedBox(height: 10),
                                          selectedProduct
                                                      .gpcFamilyDescription !=
                                                  null
                                              ? Text(
                                                'Família: ${selectedProduct.gpcFamilyDescription}',
                                              )
                                              : GpcFamilyUpdateField(
                                                focusNode: FocusNode(),
                                                // focusNodes[4],
                                              ),
                                          SizedBox(height: 10),

                                          selectedProduct.gpcClassDescription !=
                                                  null
                                              ? Text(
                                                'Class: ${selectedProduct.gpcClassDescription}',
                                              )
                                              : detailProductgpcFamilySelected !=
                                                  null
                                              ? GpcClassUpdateField()
                                              : SizedBox(),
                                          SizedBox(height: 10),

                                          selectedProduct.gpcBrickDescription !=
                                                  null
                                              ? Text(
                                                'Bloco: ${selectedProduct.gpcBrickDescription}',
                                              )
                                              : detailProductgpcClassSelected !=
                                                  null
                                              ? GpcBricksUpdateField()
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    selectedProduct.categoryName != null
                                        ? Row(
                                          children: [
                                            Text(
                                              'Categoria: ${selectedProduct.categoryName}',
                                            ),
                                          ],
                                        )
                                        : CategoriesUpdateField(),

                                    SizedBox(height: 10),
                                    selectedProduct.uCom != null
                                        ? Row(
                                          children: [
                                            Text(
                                              'Unidade Comercial: ${selectedProduct.uCom}',
                                            ),
                                          ],
                                        )
                                        : UnidadedMedidaUpdateField(),
                                    SizedBox(height: 10),

                                    selectedProduct.manufacturerBrand != null
                                        ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                width: width,
                                                child:
                                                    DetailManufacturerCardImage(
                                                      product: selectedProduct,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        )
                                        : BrandUpdateField(),
                                    SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        selectedProduct.precoMedioUnitario !=
                                                    null &&
                                                selectedProduct
                                                        .precoMedioUnitario! >
                                                    0
                                            ? ChipWidget(
                                              labelColor:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onSecondaryContainer,
                                              backgorundColor:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondaryContainer,
                                              value:
                                                  selectedProduct
                                                      .precoMedioUnitario!,
                                              iconData: Icons.input,
                                            )
                                            : SizedBox(
                                              width: width * 0.4,
                                              child: getTextField(
                                                labelText:
                                                    'Preço médio unitário (Interno)',
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                  TextInputFormatter
                                                >[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter(),
                                                ],
                                                // focusNodeCurrent: focusNodes[7],
                                                // onFieldSubmitted:
                                                //     (_) => FocusScope.of(context).requestFocus(focusNodes[8]),
                                                onChanged: (value) {
                                                  if (double.tryParse(
                                                        value
                                                            .replaceAll(
                                                              'R\$',
                                                              '',
                                                            )
                                                            .replaceAll(
                                                              ',',
                                                              '',
                                                            ),
                                                      ) ==
                                                      0) {
                                                    updateProductAverageUnitPriceAction(
                                                      null,
                                                    );
                                                  } else {
                                                    String cleanedValue = value
                                                        .replaceAll('R\$', '')
                                                        .replaceAll('.', '');
                                                    updateProductAverageUnitPriceAction(
                                                      cleanedValue,
                                                    );
                                                  }
                                                },
                                              ),
                                            ),

                                        selectedProduct.precoMedioVenda !=
                                                    null &&
                                                selectedProduct
                                                        .precoMedioVenda! >
                                                    0
                                            ? ChipWidget(
                                              labelColor:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onSecondaryContainer,
                                              backgorundColor: Color(
                                                0xFFcdeda3,
                                              ),
                                              value:
                                                  selectedProduct
                                                      .precoMedioVenda!,
                                              iconData: Icons.arrow_outward,
                                            )
                                            : SizedBox(
                                              width: width * 0.4,
                                              child: getTextField(
                                                labelText:
                                                    'Preço médio venda (Interno)',
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                  TextInputFormatter
                                                >[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter(),
                                                ],
                                                // focusNodeCurrent: focusNodes[7],
                                                // onFieldSubmitted:
                                                //     (_) => FocusScope.of(context).requestFocus(focusNodes[8]),
                                                onChanged: (value) {
                                                  if (double.tryParse(
                                                        value
                                                            .replaceAll(
                                                              'R\$',
                                                              '',
                                                            )
                                                            .replaceAll(
                                                              ',',
                                                              '',
                                                            ),
                                                      ) ==
                                                      0) {
                                                    updateProductAverageSellPriceAction(
                                                      null,
                                                    );
                                                  } else {
                                                    String cleanedValue = value
                                                        .replaceAll('R\$', '')
                                                        .replaceAll('.', '');
                                                    updateProductAverageSellPriceAction(
                                                      cleanedValue,
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    selectedProduct.description != null
                                        ? Text(
                                          'Descrição: ${selectedProduct.description}',
                                        )
                                        : getTextField(
                                          labelText: 'Descrição',
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          // focusNodeCurrent: focusNodes[9],
                                          onChanged:
                                              (value) =>
                                                  value.isEmpty
                                                      ? updateProductDesciptionAction(
                                                        null,
                                                      )
                                                      : updateProductDesciptionAction(
                                                        value,
                                                      ),
                                        ),
                                  ],
                                )
                                : CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  selectedProduct.xProd == null &&
                              selectedProduct.xProd != detailProductXProd ||
                          selectedProduct.cEAN == null &&
                              selectedProduct.cEAN != detailProductEan ||
                          selectedProduct.NCM == null &&
                              selectedProduct.NCM != detailProductNCM ||
                          selectedProduct.CEST == null &&
                              selectedProduct.CEST != detailProductCEST ||
                          selectedProduct.gpcFamilyCode == null &&
                              selectedProduct.gpcFamilyCode !=
                                  detailProductgpcFamilySelected?.familyCode ||
                          selectedProduct.category == null &&
                              selectedProduct.category !=
                                  detailProductCategory.documentId ||
                          selectedProduct.uCom == null &&
                              selectedProduct.uCom != detailProductUCom ||
                          selectedProduct.manufacturerBrand == null &&
                              selectedProduct.manufacturerBrand !=
                                  selectedManufacturer?.name ||
                          selectedProduct.precoMedioUnitario == null &&
                              selectedProduct.precoMedioUnitario !=
                                  double.tryParse(
                                    (detailProductPrecoMedioUnitario ?? '')
                                        .replaceAll(',', '.'),
                                  ) ||
                          selectedProduct.precoMedioVenda == null &&
                              selectedProduct.precoMedioVenda !=
                                  double.tryParse(
                                    (detailProductPrecoMedioVenda ?? '')
                                        .replaceAll(',', '.'),
                                  ) ||
                          selectedProduct.description == null &&
                              selectedProduct.description !=
                                  detailProductDescription
                      ? Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: UpdateButton(
                          widgetText: Text(
                            'Atualizar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onpressed: () async {
                            if (_updateFormKey.currentState!.validate()) {
                              await updateProductAction(selectedProduct);
                            } else {
                              return;
                            }
                          },
                        ),
                      )
                      : SizedBox(),
                ],
              ),
            );
          },
        )
        : SizedBox();
  }
}
