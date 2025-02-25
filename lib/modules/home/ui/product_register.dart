import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import para inputFormatters

import '../asp/actions.dart';
import '../asp/atoms.dart';
import '../helpers/helpers.dart';
import 'widgets/brand_field.dart';
import 'widgets/categories_field.dart';
import 'widgets/cnpj_field.dart';
import 'widgets/medidas_field.dart';
import 'widgets/specification_table.dart';
import 'widgets/text_field_widget.dart'; // Import para formatação de moeda

final _formKey = GlobalKey<FormState>();

class ProductRegister extends StatelessWidget with HookMixin {
  // final FocusNode focusNodeNCM = FocusNode();
  // final FocusNode focusNodePreco = FocusNode();
  // final FocusNode focusNodeCom = FocusNode();

  const ProductRegister({super.key});

  String? validateNCM(String? value) {
    if (value == null || value.isEmpty) {
      return 'NCM é obrigatório.';
    }
    if (value.length != 8) {
      return 'NCM deve ter 8 dígitos.';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'NCM deve conter apenas números.';
    }
    return null;
  }

  String? businessNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório.';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório.';
    }
    try {
      double price = parseCurrencyString(value);
      if (price <= 0) {
        return 'O preço deve ser maior que zero.';
      }
    } catch (e) {
      return 'Valor inválido. Use o formato correto.';
    }
    return null;
  }

  double parseCurrencyString(String currencyString) {
    // Remove todos os caracteres que não são dígitos ou o separador decimal
    final cleanedString = currencyString.replaceAll(RegExp(r'[^\d.,]'), '');

    // Substitui a vírgula por ponto se a localidade for 'pt_Br'
    final replacedString = cleanedString.replaceAll(',', '.');

    // Tenta fazer o parse
    return double.parse(replacedString);
  }

  String? validateCost(String? value) {
    if (value != null) {
      try {
        double cost = parseCurrencyString(value);
        if (cost <= 0) {
          return 'O custo deve ser maior que zero.';
        }
      } catch (e) {
        return 'Valor inválido. Use o formato correto.';
      }
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório.';
    }
    try {
      double quantity = double.parse(value);
      if (quantity <= 0) {
        return 'A quantidade deve ser maior que zero.';
      }
    } catch (e) {
      return 'Quantidade inválida. Use o formato correto.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final List<FocusNode> focusNodes = List.generate(10, (_) => FocusNode());

    final selectedImage = useAtomState(selectedImageState);
    final scrollController = useAtomState(scrollControllerAtom);
    final isPositionFloatingButton = useAtomState(isPositionFloatingButtonAtom);

    if (scrollController.hasClients) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            (scrollController.position.maxScrollExtent * 0.82)) {
          setPositionFloatingButtonAction(true);
        } else {
          setPositionFloatingButtonAction(false);
        }
      });
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
                  validator: businessNameValidator,
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[1]),

                  onChanged: (value) => setProductCodeAction(value),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'GTIN (Código de Barras)',
                  keyboardType: TextInputType.text,
                  focusNodeCurrent: focusNodes[1],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[2]),

                  onChanged: (value) => setProductEanAction(value),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'Nome do Produto (Opcional mostrado na NF)',
                  keyboardType: TextInputType.text,
                  focusNodeCurrent: focusNodes[2],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[3]),

                  onChanged: (value) => setProductNameAction(value),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'NCM (8 dígitos)',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  focusNodeCurrent: focusNodes[3],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[4]),

                  onChanged: (value) => setProductNCMAction(value),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'GPC Code',
                  keyboardType: TextInputType.text,
                  focusNodeCurrent: focusNodes[4],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[5]),

                  onChanged: (value) => setProductGpcCodeAction(value),
                ),
                SizedBox(height: 10),

                //!! DropDown
                CategoriesField(focusNode: focusNodes[5]),
                SizedBox(height: 10),
                UnidadedMediddaField(),
                SizedBox(height: 10),
                BrandField(),
                SizedBox(height: 10),
                CnpjField(),
                SizedBox(height: 10),
                //!! validator max length 7
                getTextField(
                  labelText: 'CEST',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  focusNodeCurrent: focusNodes[6],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[7]),

                  onChanged: (value) => setProductCESTAction(value),
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'Preço médio unitário',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  focusNodeCurrent: focusNodes[7],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[8]),

                  onChanged: (value) {
                    final parsedValue = double.tryParse(value);
                    if (parsedValue != null) {
                      setProductAverageUnitPriceAction(parsedValue);
                    }
                  },
                ),
                SizedBox(height: 10),
                getTextField(
                  labelText: 'Preço médio de venda',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  focusNodeCurrent: focusNodes[8],
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(focusNodes[9]),

                  onChanged: (value) {
                    final parsedValue = double.tryParse(value);
                    if (parsedValue != null) {
                      setProductAverageSellPriceAction(parsedValue);
                    }
                  },
                ),
                SizedBox(height: 10),

                getTextField(
                  labelText: 'Descrição',
                  keyboardType: TextInputType.multiline,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLines: 3,

                  focusNodeCurrent: focusNodes[9],

                  onChanged: (value) => setProductDescricaoAction(value),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Aqui você pode acessar os valores dos controllers e criar o objeto Product

                          //Register product
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
                      child: const Text(
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
