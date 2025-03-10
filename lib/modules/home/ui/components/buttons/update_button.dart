import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UpdateButton extends HookWidget {
  const UpdateButton({
    super.key,
    required this.widgetText,
    required this.onpressed,
  });

  final Widget widgetText;
  final Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    controller.forward();

    final Animation<double> animation = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    return ScaleTransition(
      scale: animation,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.black87,
          minimumSize: const Size.fromHeight(60),
        ),
        onPressed: onpressed,
        child: widgetText,
      ),
    );
  }
}
