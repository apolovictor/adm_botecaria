import 'package:adm_botecaria/modules/home/models/manufacturers_model.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../asp/actions.dart';
import '../../asp/atoms.dart';
import '../../asp/selectors.dart';

class BrandField extends StatelessWidget with HookMixin {
  const BrandField({
    super.key,
    required this.focusNode,
    required this.onFieldSubmitted,
  });

  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    useAtomState(getManufacturersSelector);
    final filteredManufacturersList = useAtomState(
      filteredManufacturersListAtom,
    );
    final filter = useAtomState(filterManufacturersAtom);
    final selectedManufacturer = useAtomState(selectedManufacturersAtom);

    getChip(Manufacturer manufacturer) {
      return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0, top: 3, bottom: 3),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () => setSelectedManufacturerAction(manufacturer),
            child: Text(
              manufacturer.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    generateBrands() {
      return filteredManufacturersList
          .map((brands) => getChip(brands))
          .toList();
    }

    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 60,
          child:
              filter != null && selectedManufacturer == null
                  ? TextFormField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed:
                            clearSelectedManufacturerAndFilterAction.call,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintStyle: const TextStyle(fontSize: 16),
                      labelText: 'Fabricante',
                      filled: true,
                    ),
                    onChanged: filterManufacturerAction.call,
                    onFieldSubmitted: onFieldSubmitted,
                  )
                  : filter != null && selectedManufacturer != null
                  ? TextFormField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed:
                            clearSelectedManufacturerAndFilterAction.call,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintStyle: const TextStyle(fontSize: 16),
                      labelText: 'Fabricante',
                      filled: true,
                    ),
                    onChanged: filterManufacturerAction.call,
                    controller: TextEditingController(
                      text: selectedManufacturer.name,
                    ),
                    onFieldSubmitted: onFieldSubmitted,
                  )
                  : TextFormField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed:
                            clearSelectedManufacturerAndFilterAction.call,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Digite a Marca ou CNPJ',
                      hintStyle: const TextStyle(fontSize: 16),
                      labelText: 'Fabricante',
                      filled: true,
                    ),
                    onChanged: filterManufacturerAction.call,
                    controller: TextEditingController(text: ''),
                    onFieldSubmitted: onFieldSubmitted,
                  ),
        ),
        (filter != null && selectedManufacturer == null)
            ? SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  children: [...generateBrands()],
                ),
              ),
            )
            : const SizedBox(),
      ],
    );
  }
}
