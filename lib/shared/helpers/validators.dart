import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String? cProd(String? value) =>
    value == null
        ? 'Campo obrigatório'
        : value.isEmpty || value.length > 60
        ? "Deve conter pelo menos 1 caracter e no máximo 60 "
        : null;

String? cEan(String? value) {
  if (value != null && value.isNotEmpty) {
    if (value.length < 8 || value.length > 13) {
      return "Deve conter pelo menos 8 números e no máximo 13 ";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Deve conter apenas números.';
    }
  }
  return null;
}

String? validateNCM(String? value) {
  if (value != null && value.isNotEmpty) {
    if (value.length != 8) {
      return 'NCM deve ter 8 numéricos.';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'NCM deve conter apenas números.';
    }
  }
  return null;
}

String? xProd(String? value) {
  if (value != null && value.isNotEmpty) {
    if (value.isEmpty || value.length > 120) {
      return "Deve conter pelo menos 1 caracter e no máximo 120";
    }
  }
  return null;
}

String? cest(String? value) {
  if (value != null && value.isNotEmpty) {
    if (value.length != 7) {
      return 'NCM deve ter 7 dígitos numéricos.';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'NCM deve conter apenas números.';
    }
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

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      // print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

MaskTextInputFormatter maskCnpjFormatter() => MaskTextInputFormatter(
  mask: '##.###.###/####-##',
  filter: {"#": RegExp(r'[0-9]')},
);
MaskTextInputFormatter maskCepFormatter() =>
    MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter maskPriceFormatter() =>
    MaskTextInputFormatter(mask: 'R\$ ', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter maskPhoneFormatter() => MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter maskDateFormatter() =>
    MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

String? cnpjValidator(String? fieldContent) =>
    fieldContent != null
        ? fieldContent.isEmpty
            ? 'O campo cnpj é obrigatório!'
            : null
        : 'O campo cnpj é obrigatório!';

String? nameValidator(String? fieldContent) =>
    fieldContent != null && fieldContent.length < 3
        ? "Deve conter pelo menos 3 caracteres "
        : fieldContent != null &&
            !RegExp(
              '^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+\$',
            ).hasMatch(fieldContent)
        ? 'Não pode conter caracteres especiais e números'
        : null;

String? emailValidator(String? fieldContent) =>
    fieldContent != null
        ? fieldContent.isEmpty
            ? 'O campo E-mail é obrigatório!'
            : !EmailValidator.validate(fieldContent)
            ? "Entre com um e-mail válido"
            : null
        : 'O campo E-mail é obrigatório!';

String? passwordValidator(String? fieldContent) =>
    fieldContent != null
        ? fieldContent.isEmpty
            ? 'O campo senha é obrigatório!'
            : fieldContent.length < 6
            ? 'A senha deve conter pelo menos 6 caracteres '
            : null
        : 'O campo senha é obrigatório!';
String? isEmptyValidator(String? fieldContent) =>
    fieldContent != null
        ? fieldContent.isEmpty
            ? 'Este campo é obrigatório'
            : null
        : 'Este campo é obrigatório';
String? validatePhone(String? fieldContent) =>
    fieldContent != null && fieldContent.length != 15
        ? 'O telefone deve conter 11 números'
        : null;
String? validateCep(String? fieldContent) =>
    fieldContent != null && fieldContent.length != 9
        ? 'O cep deve conter 8 números'
        : null;

// String? validatePrice(String? fieldContent) =>
//     fieldContent != null && fieldContent.isEmpty
//         ? 'O preço deve ser informado'
//         : parseCurrency(fieldContent!) == 0
//         ? 'Insira um valor numérico válido'
//         : null;

// String? validateQuantity(String? fieldContent) =>
//     fieldContent != null && fieldContent.isEmpty
//         ? 'A quantidade deve ser informada'
//         : int.tryParse(fieldContent!) == null
//         ? 'Insira um número inteiro válido'
//         : null;

// String? validateCost(String? fieldContent) =>
//     fieldContent != null && fieldContent.isEmpty
//         ? 'Insira o custo do produto'
//         : parseCurrency(fieldContent!) == 0
//         ? 'Insira um valor numérico válido'
//         : null;

String? isValidDate(String? fieldContent) =>
    fieldContent != null
        ? fieldContent.isEmpty
            ? 'Campo obrigatório'
            : fieldContent.length != 10
            ? 'Entre com uma data válida '
            : DateFormat('dd/MM/yyyy').parse(fieldContent).runtimeType !=
                DateTime
            ? 'Entre com uma data válida'
            : DateFormat(
                  'dd/MM/yyyy',
                ).parse(fieldContent).isBefore(DateTime.now()) ||
                DateFormat('dd/MM/yyyy')
                    .parse(fieldContent)
                    .isAfter(DateTime.now().add(const Duration(days: 30)))
            ? 'Apenas os próximos 30 dias'
            : null
        : null;

// bool isValidDate(String text) {
//   try {
//     // Parse the text as a date in dd/MM/yyyy format
//     DateFormat('dd/MM/yyyy').parse(text);
//     text.length == 10;
//     return true; // Valid format
//   } catch (e) {
//     return false; // Invalid format
//   }
// }

double parseCurrency(String maskedValue) {
  final cleanedValue = maskedValue.replaceAll(
    RegExp(r'[R\$.,]'),
    '',
  ); // Remove currency symbols and separators

  return double.tryParse(cleanedValue) ??
      0.0; // Correctly parse as double, handle null
}

String formatCurrency(double value) {
  //Optional. Function to format the value again
  final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  return formatter.format(value);
}

double finalParseCurrency(String maskedValue) {
  final cleanedValue = maskedValue
      .replaceAll(RegExp(r'[R\$.]'), '')
      .replaceAll(
        RegExp(r'[,]'),
        '.',
      ); // Remove currency symbols and separators

  return double.tryParse(cleanedValue) ?? 0.0;
}
