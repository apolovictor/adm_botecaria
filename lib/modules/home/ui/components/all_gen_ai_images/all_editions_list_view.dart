import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';

class AllEditionsListView extends StatelessWidget {
  const AllEditionsListView({required this.magazines, super.key});

  final List<ImagenInlineImage> magazines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'ALL EDITIONS',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: magazines.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final magazine = magazines[index];
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.memory(
                    magazine.bytesBase64Encoded,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
