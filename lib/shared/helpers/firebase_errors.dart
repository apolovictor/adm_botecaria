import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String getAuthErrorCode(String errorCode) {
  if (errorCode.contains("email-already-in-use")) {
    return 'E-mail já cadastrado. Por favor tente com um novo e-mail ou retorne para a tela de login';
  }
  if (errorCode.contains("invalid-verification-code")) {
    return 'O código SMS de confirmação é inválido. Por favor tente novamente ou reenvie um novo código';
  }

  if (errorCode.contains("network-request-failed")) {
    return 'Por favor verifique a sua conexão de internet e tente novamente';
  }
  if (errorCode.contains("unauthorized")) {
    return 'Você não tem permissão para cadastrar imagens';
  }
  if (errorCode.contains("configuration-not-found")) {
    return 'Método de login não permitido. Por favor entre em contato com o suporte';
  }
  if (errorCode.contains("invalid-credential")) {
    return 'E-mail ou senha estão incorretos!';
  }
  if (errorCode.contains("too-many-requests")) {
    return 'Várias tentativas realizadas, por favor aguarde uns minutos e tente novamente';
  } else {
    return errorCode;
  }
}

String getFirestoreErrorCode(String errorCode) {
  if (errorCode.contains("permission-denied")) {
    return 'Você não tem permissão para realizar esta ação';
  } else {
    return 'Um erro inesperado ocorreu. Se persistir, por favor entre em contato com o suporte. Error: $errorCode';
  }
}

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
