import 'package:flutter/material.dart';

void showOverlaySnackbar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: 50,
          right: 10,
          child: Material(
            // adding transparent to apply custom border
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Icon(Icons.check_circle, color: Colors.white, size: 16),
                  const SizedBox(width: 10),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 5), () {
    overlayEntry.remove();
  });
}
