import 'package:flutter/material.dart';

import '../../models/products_model.dart';

class SpecificationTable extends StatelessWidget {
  const SpecificationTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.all(0)),
              visualDensity: VisualDensity(horizontal: 0.0, vertical: 0.0),
              fixedSize: WidgetStateProperty.all(Size(10, 15)),
              alignment: Alignment(-1, 0),
              iconAlignment: IconAlignment.start,
            ),
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text("Tabela de Especificações", style: TextStyle(fontSize: 14)),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: 5,
              horizontalMargin: 0,
              columns: const [
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.start,
                  label: Text(
                    'Código',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Tipo',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Nome do campo',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Resumo',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
              rows:
                  productSpecifications
                      .map(
                        (spec) => DataRow(
                          cells: [
                            DataCell(Text(spec.campo)),
                            DataCell(Text(spec.tipo)),
                            DataCell(Text(spec.labelText)),
                            DataCell(Text(spec.resumo)),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
