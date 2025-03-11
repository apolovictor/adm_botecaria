import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../../asp/actions.dart';
import '../../../asp/atoms.dart';
import '../../../asp/selectors.dart';

class UnidadedMediddaField extends StatelessWidget with HookMixin {
  const UnidadedMediddaField({super.key});

  @override
  Widget build(BuildContext context) {
    useAtomState(getUnidadesDeMedidaSelector);

    final unidadesDeMedidaList = useAtomState(unidadesDeMeddidaListAtom);

    return SizedBox(
      width: double.maxFinite,
      height: 60,
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          label: Text('Unidade de Medida'),
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
        onChanged: (value) => setProductUComAction(value!.name),
        items:
            unidadesDeMedidaList.map((e) {
              return DropdownMenuItem(
                value: e,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.name),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Text(e.documentId.toString()),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
