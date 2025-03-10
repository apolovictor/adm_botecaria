import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';

buildBarcode(
  String data, {
  String? filename,
  required double width,
  required double height,
  double? fontHeight,
}) {
  return data.length == 8
      ? BarcodeWidget(
        barcode: Barcode.ean8(drawSpacers: true),
        data: data,
        width: width * 0.4,
        height: height,
      )
      : BarcodeWidget(
        barcode: Barcode.ean13(drawEndChar: true),
        data: data,
        width: width * 0.4,
        height: height,
      );
  // /// Create the Barcode
  // final svg = bc.toSvg(
  //   data,
  //   width: width ?? 200,
  //   height: height ?? 80,
  //   fontHeight: fontHeight,
  // );

  // // Save the image
  // filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
  // return File('$filename.svg').writeAsStringSync(svg);

  // return result;
}
