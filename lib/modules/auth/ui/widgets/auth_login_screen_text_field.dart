import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../asp/actions.dart';

Widget getTextField({
  required BuildContext context,
  required String labelText,
  String? Function(String?)? validator,
  FocusNode? focusNodeCurrent,
  FocusNode? focusNodeNext,
  bool? obsectextType,
  IconData? suffixIcon,
  TextInputType? textType,
  int? length,
  int maxLines = 1,
  bool? enablefield,
  Color? color,
  List<TextInputFormatter>? inputFormatters,
  GestureTapCallback? callback,
  String? errorText,
}) {
  return TextFormField(
    // validator: (validators) => validators,
    maxLines: maxLines,
    keyboardType: textType,
    obscureText: obsectextType ?? false,
    focusNode: focusNodeCurrent,
    enabled: enablefield,
    validator: validator,
    textInputAction: TextInputAction.next,
    onFieldSubmitted: (value) {
      focusNodeCurrent?.unfocus();
      if (focusNodeNext != null) {
        FocusScope.of(context).autofocus(focusNodeNext);
      }
    },
    onTap: callback,
    maxLength: length,
    onChanged: (value) => setLoginEmailAction(value),

    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      errorText: errorText,
      hintText: labelText,
      hintStyle: const TextStyle(fontSize: 16),
      labelText: labelText,
      filled: true,
      suffixIcon: Padding(
        padding: const EdgeInsetsDirectional.only(end: 0.0),
        child: Icon(suffixIcon, size: 20, color: color),
      ),
    ),
  );
}
