import 'package:adm_botecaria/modules/home/providers/states/product_states.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/gpc_bricks_field.dart';
import 'package:adm_botecaria/modules/home/ui/widgets/gpc_family_field.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/helpers/validators.dart';
import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../helpers/helpers.dart';
import 'widgets/brand_field.dart';
import 'widgets/categories_field.dart';
import 'widgets/gpc_class_field.dart';
import 'widgets/medidas_field.dart';
import 'widgets/specification_table.dart';
import 'widgets/text_field_widget.dart';

final _formKey = GlobalKey<FormState>();

class ProductRegister extends StatelessWidget with HookMixin {
  const ProductRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FocusNode> focusNodes = List.generate(11, (_) => FocusNode());

    final selectedImage = useAtomState(selectedImageState);
    final scrollController = useAtomState(scrollControllerAtom);
    final isPositionFloatingButton = useAtomState(isPositionFloatingButtonAtom);
    final gpcFamilySelected = useAtomState(gpcFamilySelectedAtom);
    final gpcClassSelected = useAtomState(gpcClassSelectedAtom);

    final productState = useAtomState(productStateAtom);

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
                                onPressed: () {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) async {
                                    await getGalleryImage(100, 100);
                                  });
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
