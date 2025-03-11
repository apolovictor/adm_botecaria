import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../asp/actions.dart';
import '../../../asp/atoms.dart';
import '../../../asp/selectors.dart';
import '../../../providers/category_icon_provider.dart';

class CategoriesUpdateField extends ConsumerWidget {
  const CategoriesUpdateField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AtomBuilder(
      builder: (_, get) {
        get(getCategoriesSelector);

        final categoriesList = get(categoriesListAtom);

        categoriesList.sort((a, b) => a.iconName!.compareTo(b.iconName!));
        return SizedBox(
          width: double.maxFinite,
          height: 60,
          child: DropdownButtonFormField(
            isExpanded: true,
            decoration: InputDecoration(
              label: Text('Categoria (Interno)'),
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
            onChanged: (value) => updateProductCategoriaAction(value!),
            items:
                categoriesList.map((e) {
                  final asyncSvgOptionsWidget = ref.watch(
                    categoryIconProvider(e),
                  );

                  return DropdownMenuItem(
                    value: e,
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.iconName!),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: asyncSvgOptionsWidget.when(
                              data: (svgPicture) => svgPicture,
                              loading: () => const CircularProgressIndicator(),
                              error:
                                  (error, stackTrace) =>
                                      const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
