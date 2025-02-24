import 'package:flutter/material.dart';

import '../../asp/actions.dart';

Widget passwordFieldWidget(
  FocusNode? focusNodeCurrent,
  String fieldName,
  BuildContext context,
  String? Function(String?)? validator,
) {
  return TextFormField(
    obscureText: true,
    focusNode: focusNodeCurrent,
    onFieldSubmitted: (value) {
      focusNodeCurrent?.unfocus();
    },
    onChanged: (value) => setLoginPasswordAction(value),
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: fieldName,
      filled: true,
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
  );
}
