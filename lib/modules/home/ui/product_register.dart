import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import para inputFormatters
import 'package:intl/intl.dart';

import '../asp/actions.dart'; // Import para formatação de moeda

final _formKey = GlobalKey<FormState>();

class ProductRegister extends StatelessWidget {
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
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório.';
    }
    try {
      double cost = parseCurrencyString(value);
      if (cost <= 0) {
        return 'O custo deve ser maior que zero.';
      }
    } catch (e) {
      return 'Valor inválido. Use o formato correto.';
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
    final List<FocusNode> focusNodes = List.generate(27, (_) => FocusNode());

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Código do Produto (Interno)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[0],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[1]),
                onChanged: (value) => setProductCodeAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'GTIN (Código de Barras)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[1],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[2]),
                onChanged: (value) => setProductEANAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome Produto (Opcional mostrado na NF)',
                ),
                keyboardType: TextInputType.text,
                validator: businessNameValidator,
                focusNode: focusNodes[2],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[3]),
                onChanged: (value) => setProductNameAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'NCM (8 dígitos)'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validateNCM,
                focusNode: focusNodes[3],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[4]),
                onChanged: (value) => setProductNCMAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Código EX TIPI (Opcional)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[4],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[5]),
                onChanged: (value) => setProductEXTIPIAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CFOP'),
                initialValue: '5102',
                keyboardType: TextInputType.number,
                focusNode: focusNodes[5],
                enabled: false,
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[6]),
                onChanged: (value) => setProductCFOPAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Unidade Comercial',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[6],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[7]),
                onChanged: (value) => setProductUComAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantidade Comercial',
                ),
                keyboardType: TextInputType.number,
                validator: validateQuantity,
                focusNode: focusNodes[7],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[8]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductQComAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valor Unitário'),
                keyboardType: TextInputType.number,
                focusNode: focusNodes[8],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[9]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductVUnComAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valor Produto'),
                keyboardType: TextInputType.number,
                focusNode: focusNodes[9],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[10]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductVProdAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Url Imagem'),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[10],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[11]),
                onChanged: (value) => setProductImageUrlAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Categoria'),
                keyboardType: TextInputType.text,
                validator: businessNameValidator,
                focusNode: focusNodes[11],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[12]),
                onChanged: (value) => setProductCategoriaAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'GPC Code'),
                keyboardType: TextInputType.text,
                validator: businessNameValidator,
                focusNode: focusNodes[12],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[13]),
                onChanged: (value) => setProductGpcCodeAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Marca'),
                keyboardType: TextInputType.text,
                validator: businessNameValidator,
                focusNode: focusNodes[13],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[14]),
                onChanged: (value) => setProductMarcaAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: focusNodes[14],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[15]),
                onChanged: (value) => setProductDescricaoAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CEST (Opcional)'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                focusNode: focusNodes[15],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[16]),
                onChanged: (value) => setProductCESTAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Indicador Escala (Opcional)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[16],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[17]),
                onChanged: (value) => setProductIndEscalaAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CNPJ Fabricante (Opcional)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                focusNode: focusNodes[17],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[18]),
                onChanged: (value) => setProductCNPJFabAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cod Benef (Opcional)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[18],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[19]),
                onChanged: (value) => setProductCBenefAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantidade no Lote (Opcional)',
                ),
                keyboardType: TextInputType.number,
                focusNode: focusNodes[19],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[20]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductQVolAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Unidade Tributável (Opcional)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[20],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[21]),
                onChanged: (value) => setProductUTribAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantidade Tributável (Opcional)',
                ),
                keyboardType: TextInputType.number,
                focusNode: focusNodes[21],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[22]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductQTribAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Valor Unitário Tributação (Opcional)',
                ),
                keyboardType: TextInputType.number,
                focusNode: focusNodes[22],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[23]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductVUnTribAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NLote (Opcional)',
                ),
                keyboardType: TextInputType.text,
                focusNode: focusNodes[23],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[24]),
                onChanged: (value) => setProductNLoteAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantidade no lote (Opcional)',
                ),
                keyboardType: TextInputType.number,
                focusNode: focusNodes[24],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[25]),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    setProductQLoteAction(parsedValue);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'dFab (Opcional)'),
                keyboardType: TextInputType.datetime,
                focusNode: focusNodes[25],
                onFieldSubmitted:
                    (_) => FocusScope.of(context).requestFocus(focusNodes[26]),
                onChanged: (value) => setProductDFabAction(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'dVal (Opcional)'),
                keyboardType: TextInputType.datetime,
                focusNode: focusNodes[26],
                onChanged: (value) => setProductDValAction(value),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Aqui você pode acessar os valores dos controllers e criar o objeto Product
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
