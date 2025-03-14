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
        width: 180,
        height: height,
      )
      : BarcodeWidget(
        barcode: Barcode.ean13(drawEndChar: true),
        data: data,
        width: 180,
        height: height,
      );
}
