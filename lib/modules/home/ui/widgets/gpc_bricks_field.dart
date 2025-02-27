import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../asp/actions.dart';
import '../../asp/atoms.dart';
import '../../asp/selectors.dart';

class GpcBricksField extends StatelessWidget with HookMixin {
  const GpcBricksField({super.key});

  @override
  Widget build(BuildContext context) {
    useAtomState(getGpcBrickSelector);

    final gpcBrickList = useAtomState(gpcBrickListAtom);
    if (gpcBrickList.isNotEmpty) {
      gpcBrickList.sort(
        (a, b) => a.brickDescription.compareTo(b.brickDescription),
      );
    }
    return gpcBrickList.isNotEmpty
        ? SizedBox(
          width: double.maxFinite,
          height: 60,
          child: DropdownButtonFormField(
            isExpanded: true,
            decoration: InputDecoration(
              label: Text('GPC Brick'),
              labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              // hintText: productCategory,
            ),
            // value: widget.category,
            onChanged: (value) => setGpcBrickSelectedAction(value!),
            items:
                gpcBrickList.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: SizedBox(
                      height: 50,
                      child: Text(e.brickDescription),
                    ),
                  );
                }).toList(),
          ),
        )
        : SizedBox();
  }
}
