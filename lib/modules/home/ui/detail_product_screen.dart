import 'package:adm_botecaria/modules/home/ui/widgets/barcode.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/detail_manufacturer_card_image.dart';
import 'package:asp/asp.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../helpers/helpers.dart';
import '../providers/states/detail_product_states.dart';
import 'widgets/detail_product_card_image.dart';

class DetailProductPage extends StatelessWidget with HookMixin {
  const DetailProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedProduct = useAtomState(selectedProductAtom);
    final detailProductStatus = useAtomState(detailProductStatusState);
    final selectedImage = useAtomState(selectedImageOfDetailProductState);

    final width = MediaQuery.sizeOf(context).width;

    final NCMString = selectedProduct?.NCM.toString();

    return detailProductStatus is! DetailProductStatesLoading
        ? selectedProduct != null
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    selectedProduct.imageUrl != null
                        ? selectedProduct.imageUrl!.isNotEmpty
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
                            : selectedImage == null
                            ? Hero(
                              tag: selectedProduct.documentId!,
                              child: Container(
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
                            : Hero(
                              tag: selectedProduct.documentId!,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: ClipOval(
                                        child: Image.memory(
                                          selectedImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -10,
                                      // left: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.grey.shade900,
                                        ),
                                        onPressed:
                                            clearDetailProductImageAction.call,
                                      ),
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
                            borderRadius: BorderRadius.circular((width) * 0.3),
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
                    SizedBox(height: 10),
                    Text(selectedProduct.cProd, textAlign: TextAlign.center),
                    SizedBox(height: 5),
                    Text(
                      'Nome na NFC-e: ${selectedProduct.xProd}',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildBarcode(
                          selectedProduct.cEAN.toString(),
                          width: width,
                          height: 80,
                          // selectedProduct.cEAN.toString().length == 13
                          //     ? Barcode.ean13(drawEndChar: true)
                          //     : Barcode.ean8(),
                          // selectedProduct.cEAN.toString(),
                        ),
                      ],
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
                        : SizedBox(),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('GPC', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 5),

                          Text('Segmento: Comidas e Bebidas'),
                          Text(
                            'Família: ${selectedProduct.gpcFamilyDescription}',
                          ),
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
                          children: [
                            Text(
                              'Fabricante: ${selectedProduct.manufacturerBrand}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: DetailManufacturerCardImage(
                            product: selectedProduct,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            : SizedBox()
        : Center(child: CircularProgressIndicator());
  }
}
