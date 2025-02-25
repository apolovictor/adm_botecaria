import 'package:flutter/material.dart';

class BrandField extends StatelessWidget {
  const BrandField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 60,
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          label: Text('Marca'),
          labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
          focusColor: Colors.black54,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          // fillColor: Color(
          //   int.parse(widget.product.secondaryColor),
          // ),
          filled: true,
          // hintText: productCategory,
        ),
        // value: widget.category,
        onChanged: (_) {},
        //     (value) => setDetailProductCategoryAction(
        //       value!.iconName,
        //     ),
        items: [],
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
