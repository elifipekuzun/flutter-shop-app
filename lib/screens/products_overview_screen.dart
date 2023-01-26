import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreeen extends StatelessWidget {
  const ProductsOverviewScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
