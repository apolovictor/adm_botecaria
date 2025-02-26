import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../asp/actions.dart';
import '../../asp/atoms.dart';
import '../../asp/selectors.dart';

class GpcFamilyField extends StatelessWidget with HookMixin {
  const GpcFamilyField({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    useAtomState(getGpcFamilySelector);

    final gpcFamilyList = useAtomState(gpcFamilyListAtom);

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
          // hintText: productCategory,
        ),
        // value: widget.category,
        onChanged: (value) => setGpcFamilySelectedAction(value!),
        items:
            gpcFamilyList.map((e) {
              return DropdownMenuItem(
                value: e,
                child: SizedBox(height: 50, child: Text(e.familyDescription)),
              );
            }).toList(),
        // categoriesList.map((e) {
        //   final asyncSvgOptionsWidget = ref.watch(
        //     categoryIconProvider(e),
        //   );

        // return DropdownMenuItem(
        //   value: e,
        //   child: SizedBox(
        //     height: 50,
        //     child: Row(
        //       mainAxisAlignment:
        //           MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(e.iconName),
        //         SizedBox(
        //           height: 20,
        //           width: 20,
        //           child: asyncSvgOptionsWidget.when(
        //             data:
        //                 (svgPicture) => svgPicture,
        //             loading:
        //                 () =>
        //                     const CircularProgressIndicator(),
        //             error:
        //                 (error, stackTrace) =>
        //                     const Icon(Icons.error),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        // }).toList(),
      ),
    );
  }
}
