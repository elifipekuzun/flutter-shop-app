import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<ProductsProvider>(ctx, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (cxt, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: (() => _refreshProducts(context)),
                child: Consumer<ProductsProvider>(
                  builder: ((ctx, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: productsData.items.isEmpty
                            ? const Center(
                                child: Text('No product added!.'),
                              )
                            : ListView.builder(
                                itemCount: productsData.items.length,
                                itemBuilder: (_, index) => Column(
                                      children: [
                                        UserProductItem(
                                            deleteProduct: (String id) async {
                                              try {
                                                await productsData
                                                    .deleteProduct(id);
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            duration: Duration(
                                                                seconds: 2),
                                                            content: Text(
                                                              'Deleting failed!',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )));
                                              }
                                            },
                                            id: productsData.items[index].id!,
                                            title:
                                                productsData.items[index].title,
                                            imageUrl: productsData
                                                .items[index].imageUrl),
                                        const Divider(),
                                      ],
                                    )),
                      )),
                )),
      ),
    );
  }
}
