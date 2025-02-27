import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getTextField({
  required String labelText,
  required TextInputType keyboardType,
  String? Function(String?)? validator,
  String? prefixText,
  FocusNode? focusNodeCurrent,
  FocusNode? focusNodeNext,
  Function(String)? onFieldSubmitted,
  required Function(String)? onChanged,
  int? maxLines = 1,
  bool? enablefield,
  List<TextInputFormatter>? inputFormatters,
  GestureTapCallback? callback,
  String? errorText,
}) {
  return TextFormField(
    maxLines: maxLines,
    keyboardType: keyboardType,
    focusNode: focusNodeCurrent,
    enabled: enablefield,
    inputFormatters: inputFormatters,
    textInputAction: TextInputAction.next,
    onFieldSubmitted: onFieldSubmitted,
    onTap: callback,
    onChanged: onChanged,
    validator: validator,
    decoration: InputDecoration(
      prefixText: prefixText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      errorText: errorText,
      hintText: labelText,
      hintStyle: const TextStyle(fontSize: 16),
      labelText: labelText,
      filled: true,
    ),
  );
}
