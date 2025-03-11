import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../../asp/actions.dart';
import '../../../asp/atoms.dart';
import '../../../asp/selectors.dart';

class GpcFamilyUpdateField extends StatelessWidget with HookMixin {
  const GpcFamilyUpdateField({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    useAtomState(getGpcFamilyUpdateSelector);

    final gpcFamilyList = useAtomState(gpcFamilyUpdateListAtom);
    final detailProductgpcFamilySelected = useAtomState(
      detailProductgpcFamilySelectedAtom,
    );

    gpcFamilyList.sort(
      (a, b) => a.familyDescription.compareTo(b.familyDescription),
    );
    return SizedBox(
      width: double.maxFinite,
      height: 60,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        isExpanded: true,
        decoration: InputDecoration(
          label: Text('GPC Familia'),
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
          fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          suffixIcon:
              detailProductgpcFamilySelected != null
                  ? IconButton(
                    onPressed: () {
                      updateGPCFamilyAction(null);
                      updateGPCClassAction(null);
                      updateGPCBrickAction(null);
                    },
                    icon: Icon(Icons.close),
                  )
                  : null,
        ),
        value: detailProductgpcFamilySelected,
        onChanged: (value) => updateGPCFamilyAction(value!),
        items:
            gpcFamilyList.map((e) {
              return DropdownMenuItem(
                value: e,
                child: SizedBox(height: 50, child: Text(e.familyDescription)),
              );
            }).toList(),
      ),
    );
  }
}
