import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../../asp/actions.dart';
import '../../../asp/atoms.dart';
import '../../../asp/selectors.dart';

class GpcClassField extends StatelessWidget with HookMixin {
  const GpcClassField({super.key});

  @override
  Widget build(BuildContext context) {
    useAtomState(getGpcClassSelector);

    final gpcClassList = useAtomState(gpcClassListAtom);
    if (gpcClassList.isNotEmpty) {
      gpcClassList.sort(
        (a, b) => a.classDescription.compareTo(b.classDescription),
      );
    }
    return gpcClassList.isNotEmpty
        ? SizedBox(
          width: double.maxFinite,
          height: 60,
          child: DropdownButtonFormField(
            isExpanded: true,
            decoration: InputDecoration(
              label: Text('GPC classes'),
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
            onChanged: (value) => setGpcClassSelectedAction(value!),
            items:
                gpcClassList.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: SizedBox(
                      height: 50,
                      child: Text(e.classDescription),
                    ),
                  );
                }).toList(),
          ),
        )
        : SizedBox();
  }
}
