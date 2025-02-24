import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter maskCnpjFormatter() => MaskTextInputFormatter(
  mask: '##.###.###/####-##',
  filter: {"#": RegExp(r'[0-9]')},
);
MaskTextInputFormatter maskCepFormatter() =>
    MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter maskCpfFormatter() => MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
);

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

String? businessNameValidator(String? fieldContent) =>
    fieldContent != null && fieldContent.length < 3
        ? "Deve conter pelo menos 3 caracteres "
        : null;

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

String? validatePrice(String? fieldContent) =>
    fieldContent != null && fieldContent.isEmpty
        ? 'O preço deve ser informado'
        : parseCurrency(fieldContent!) == 0
        ? 'Insira um valor numérico válido'
        : null;

String? validateQuantity(String? fieldContent) =>
    fieldContent != null && fieldContent.isEmpty
        ? 'A quantidade deve ser informada'
        : int.tryParse(fieldContent!) == null
        ? 'Insira um número inteiro válido'
        : null;

String? validateCost(String? fieldContent) =>
    fieldContent != null && fieldContent.isEmpty
        ? 'Insira o custo do produto'
        : parseCurrency(fieldContent!) == 0
        ? 'Insira um valor numérico válido'
        : null;

// String? isValidDate(String text) {
//   try {
//     // Parse the text as a date in dd/MM/yyyy format
//     DateTime.parse(
//         DateFormat('dd/MM/yyyy').format(DateFormat('dd/MM/yyyy').parse(text)));
//     return null; // Valid format
//   } catch (e) {
//     return 'Formato inválido'; // Invalid format
//   }
// }

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
