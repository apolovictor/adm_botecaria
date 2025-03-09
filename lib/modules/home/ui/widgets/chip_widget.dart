import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.labelColor,
    required this.backgorundColor,
    required this.value,
    required this.iconData,
  });

  final Color labelColor;
  final Color backgorundColor;
  final double value;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'R\$ ${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Icon(iconData, color: Theme.of(context).colorScheme.secondary),
        ],
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      labelStyle: TextStyle(color: labelColor),
      backgroundColor: backgorundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
