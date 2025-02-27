import 'package:flutter/material.dart';

import '../asp/actions.dart';
import '../providers/states/product_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setProductStateAction(ProductStatusStateInitial());
    });
    return Container(child: Center(child: Text('Homepage')));
  }
}
