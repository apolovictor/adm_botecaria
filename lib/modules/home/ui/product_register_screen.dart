import 'package:adm_botecaria/modules/home/providers/states/product_states.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/register/gpc_bricks_field.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/register/gpc_family_field.dart';
import 'package:adm_botecaria/shared/widgets/behavior.dart';
import 'package:asp/asp.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../setup_locator.dart';
import '../../../shared/helpers/validators.dart';
import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../helpers/helpers.dart';
import 'widgets/register/brand_field.dart';
import 'widgets/register/categories_field.dart';
import 'widgets/register/gpc_class_field.dart';
import 'widgets/register/medidas_field.dart';
import 'widgets/specification_table.dart';
import 'widgets/text_field_widget.dart';
import 'dart:ui'
    as ui
    show Codec, FrameInfo, ImageByteFormat, instantiateImageCodec;
import 'dart:typed_data' as typed_data show ByteData, Uint8List;
import 'package:image/image.dart' as img;

final _formKey = GlobalKey<FormState>();

class ProductRegisterPage extends StatelessWidget with HookMixin {
  const ProductRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FocusNode> focusNodes = List.generate(11, (_) => FocusNode());

    final selectedImage = useAtomState(selectedImageState);
    final scrollController = useAtomState(scrollControllerAtom);
    final isPositionFloatingButton = useAtomState(isPositionFloatingButtonAtom);
    final gpcFamilySelected = useAtomState(gpcFamilySelectedAtom);
    final gpcClassSelected = useAtomState(gpcClassSelectedAtom);
    final productState = useAtomState(productStateAtom);
    final productCode = useAtomState(productCodeAtom);
    final imageList = useAtomState(imagenInlineImageListAtom);

    useAtomEffect((get) {
      get(scrollControllerAtom).addListener(() {
        if (get(scrollControllerAtom).position.pixels >=
            (get(scrollControllerAtom).position.maxScrollExtent * 0.8)) {
          setPositionFloatingButtonAction(true);
        } else {
          setPositionFloatingButtonAction(false);
        }
      });
      return () {
        get(scrollControllerAtom).removeListener(() {});
      };
    });

    Future<Uint8List> resizeImage(Uint8List fileBytes) async {
      // Resize image
      ui.Codec codec = await ui.instantiateImageCodec(
        fileBytes,
        targetWidth: 200,
      );
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      final resizedImage = frameInfo.image;

      typed_data.ByteData? resizedByteData =
          await resizedImage.toByteData(format: ui.ImageByteFormat.png)
              as typed_data.ByteData;
      typed_data.Uint8List resizedUint8List = resizedByteData.buffer
          .asUint8List(
            resizedByteData.offsetInBytes,
            resizedByteData.lengthInBytes,
          );

      return resizedUint8List;
    }

    Future<img.Image?> loadImage(typed_data.Uint8List fileBytes) async {
      try {
        img.Image? decodedImage = img.decodeImage(fileBytes);
        if (decodedImage == null) {
          print("Error: Could not decode image.");
          return null;
        }
        return decodedImage;
      } catch (e) {
        print('Error in loadImage: $e');
        return null;
      }
    }

    img.Image removeWhiteBackground(img.Image src) {
      for (int y = 0; y < src.height; y++) {
        for (int x = 0; x < src.width; x++) {
          final pixel = src.getPixel(x, y);
          int r = pixel.r.toInt();
          int g = pixel.g.toInt();
          int b = pixel.b.toInt();
          if (r > 240 && g > 240 && b > 240) {
            src.setPixelRgba(x, y, 255, 255, 255, 0);
          }
        }
      }
      return src;
    }

    return Scaffold(
      floatingActionButtonLocation:
          isPositionFloatingButton
              ? FloatingActionButtonLocation.endTop
              : FloatingActionButtonLocation.endFloat,
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectedImage == null
                        ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.grey],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100),
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
                                  return await openActionSheet(
                                    100,
                                    100,
                                    context,
                                    [],
                                  );
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : SizedBox(
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
                                  onPressed: clearProductImageAction.call,
                                ),
                              ),
                            ],
                          ),
                        ),
                    productCode.length > 2
                        ? IconButton(
                          onPressed: () async {
                            clearImagenInlineImageList();
                            final ImagenModel imagenModel =
                                getIt<ImagenModel>();

                            final prompt =
                                'One picuture for product $productCode on a opaque solid white color background. With thumbnail quality. Withou shadow, gradients';
                            print('prompt === $prompt');
                            // To generate images, call `generateImages` with the text prompt
                            final response = await imagenModel.generateImages(
                              prompt,
                            );

                            // If fewer images were generated than were requested,
                            // then `filteredReason` will describe the reason they were filtered out
                            if (response.filteredReason != null) {
                              print(response.filteredReason);
                            }

                            if (response.images.isNotEmpty) {
                              final images = response.images;
                              addToimagenInlineImageList(images);
                            } else {
                              // Handle the case where no images were generated
                              debugPrint('Error: No images were generated.');
                            }
                          },
                          icon: Icon(Icons.deblur),
                        )
                        : SizedBox(),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var image in imageList)
                                Container(
                                  width: 300,
                                  height: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: InkWell(
                                    child: Image.memory(
                                      image.bytesBase64Encoded,
                                      width: 300,
                                      height: 300,
                                    ),
                                    onTap: () async {
                                      final imageResponse = await resizeImage(
                                        image.bytesBase64Encoded,
                                      );
                                      final loadedImage = await loadImage(
                                        imageResponse,
                                      );
                                      if (loadedImage != null) {
                                        final processedImage =
                                            removeWhiteBackground(loadedImage);
                                        List<int> pngBytes = img.encodePng(
                                          processedImage,
                                        ); // Use encodePng for web compatibility

                                        typed_data.Uint8List
                                        processedUint8List = typed_data
                                            .Uint8List.fromList(
                                          pngBytes,
                                        ); // Convert to Uint8List

                                        setProductImageAction(
                                          processedUint8List,
                                        );
                                      }
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                getTextField(
                  labelText: 'Código do Produto (Interno) *',
                  keyboardType: TextInputType.text,
                  focusNodeCurrent: focusNodes[0],
                  validator: cProd,
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[1]),

                  onChanged: (value) => setProductCodeAction(value),
                ),
                SizedBox(height: 10),

                getTextField(
                  labelText: 'Nome do Produto (Opcional mostrado na NF)',
                  keyboardType: TextInputType.text,
                  focusNodeCurrent: focusNodes[1],
                  validator: xProd,
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[2]),

                  onChanged: (value) => setProductNameAction(value),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'GTIN (Código de Barras)',
                  keyboardType: TextInputType.number,
                  focusNodeCurrent: focusNodes[2],

                  validator: cEan,
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[3]),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged:
                      (value) => setProductEanAction(double.tryParse(value)),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'NCM (8 dígitos)',
                  keyboardType: TextInputType.number,
                  validator: validateNCM,

                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  focusNodeCurrent: focusNodes[3],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[4]),

                  onChanged:
                      (value) => setProductNCMAction(double.tryParse(value)),
                ),
                SizedBox(height: 10),
                //!! validator max length 7
                getTextField(
                  labelText: 'CEST',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: cest,
                  focusNodeCurrent: focusNodes[6],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[7]),

                  onChanged:
                      (value) => setProductCESTAction(double.tryParse(value)),
                ),
                SizedBox(height: 10),

                //!! DropDown
                GpcFamilyField(focusNode: focusNodes[4]),
                SizedBox(height: 10),
                gpcFamilySelected != null ? GpcClassField() : SizedBox(),
                gpcFamilySelected != null ? SizedBox(height: 10) : SizedBox(),
                gpcClassSelected != null ? GpcBricksField() : SizedBox(),
                gpcClassSelected != null ? SizedBox(height: 10) : SizedBox(),
                CategoriesField(),
                SizedBox(height: 10),
                UnidadedMediddaField(),
                SizedBox(height: 10),
                BrandField(
                  focusNode: focusNodes[5],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[6]),
                ),

                SizedBox(height: 10),
                getTextField(
                  labelText: 'Preço médio unitário (Interno)',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  focusNodeCurrent: focusNodes[7],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[8]),
                  onChanged: (value) {
                    String cleanedValue = value
                        .replaceAll('R\$', '')
                        .replaceAll('.', '');
                    setProductAverageUnitPriceAction(cleanedValue);
                  },
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'Preço médio de venda (Interno)',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  focusNodeCurrent: focusNodes[8],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[9]),
                  onChanged: (value) {
                    String cleanedValue = value
                        .replaceAll('R\$', '')
                        .replaceAll('.', '');
                    setProductAverageSellPriceAction(cleanedValue);
                  },
                ),
                SizedBox(height: 10),

                getTextField(
                  labelText: 'Descrição',
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNodeCurrent: focusNodes[9],
                  onChanged: (value) => setProductDesciptionAction(value),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed:
                          productState is ProductStatusStateLoadingAdding
                              ? null
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  addProductAction();
                                } else {
                                  return;
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Colors.black87,
                      ),
                      child:
                          productState is ProductStatusStateLoadingAdding
                              ? CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                'Salvar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            useSafeArea: false,
            builder: (BuildContext context) {
              return SpecificationTable();
            },
          );
        },
        backgroundColor: Colors.black87,
        child: Icon(Icons.help, color: Colors.white),
      ),
    );
  }
}

Future<void> openActionSheet(
  double maxWidth,
  double maxHeight,
  BuildContext context,
  // List<CameraDescription> cameras,
  List<dynamic>? photos,
) {
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Tirar Foto",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.pop(context);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return CameraApp(cameras: cameras, page: page);
              //     },
              //   ),
              // );
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Escolher Foto",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () async {
              await getGalleryImage(100, 100);

              // page == 'register'
              //     ? _getGalleryImage(maxWidth, maxHeight, ref, context)
              //     : _getGalleryImageDetailPage(
              //         maxWidth, maxHeight, ref, context, photos);

              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      );
    },
  );
}
