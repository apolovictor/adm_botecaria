import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../asp/actions.dart';

import 'dart:ui'
    as ui
    show Codec, FrameInfo, ImageByteFormat, instantiateImageCodec;
import 'dart:typed_data' as typed_data show ByteData, Uint8List;
import 'package:image/image.dart' as img;

Future<Uint8List> resizeImage(Uint8List fileBytes) async {
  // Resize image
  ui.Codec codec = await ui.instantiateImageCodec(fileBytes, targetWidth: 200);
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  final resizedImage = frameInfo.image;

  typed_data.ByteData? resizedByteData =
      await resizedImage.toByteData(format: ui.ImageByteFormat.png)
          as typed_data.ByteData;
  typed_data.Uint8List resizedUint8List = resizedByteData.buffer.asUint8List(
    resizedByteData.offsetInBytes,
    resizedByteData.lengthInBytes,
  );

  return resizedUint8List;
}

Future<img.Image?> loadImage(typed_data.Uint8List fileBytes) async {
  try {
    img.Image? decodedImage = img.decodeImage(fileBytes);
    if (decodedImage == null) {
      debugPrint("Error: Could not decode image.");
      return null;
    }
    return decodedImage;
  } catch (e) {
    debugPrint('Error in loadImage: $e');
    return null;
  }
}

img.Image removeWhiteBackground(img.Image src) {
  for (int y = 0; y < src.height; y++) {
    for (int x = 0; x < src.width; x++) {
      final pixel = src.getPixel(x, y);
      int r = pixel.r.toInt();
      int g = pixel.g.toInt();
      int b = pixel.b.toInt();
      if (r > 240 && g > 240 && b > 240) {
        src.setPixelRgba(x, y, 255, 255, 255, 0);
      }
    }
  }
  return src;
}

class MagazineCoverImage extends StatelessWidget {
  const MagazineCoverImage({required this.image, super.key, this.height});

  final ImagenInlineImage image;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          final imageResponse = await resizeImage(image.bytesBase64Encoded);
          final loadedImage = await loadImage(imageResponse);
          if (loadedImage != null) {
            final processedImage = removeWhiteBackground(loadedImage);
            List<int> pngBytes = img.encodePng(
              processedImage,
            ); // Use encodePng for web compatibility
            typed_data.Uint8List processedUint8List = typed_data
                .Uint8List.fromList(pngBytes); // Convert to Uint8List
            setProductImageAction(processedUint8List);
          }
        },
        child: AspectRatio(
          aspectRatio: .75,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.memory(image.bytesBase64Encoded).image,
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 40,
                  offset: Offset(-20, 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
