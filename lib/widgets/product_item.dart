import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  void selectProduct(BuildContext ctx, String pid) {
    Navigator.of(ctx).pushNamed(ProductDetailScreen.routeName, arguments: pid);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Consumer<Product>(
      builder: (context, productItem, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: IconButton(
                icon: Icon(
                  productItem.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  productItem.toggleFavoriteStatus();
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  cart.addItem(
                      productItem.id!, productItem.price, productItem.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Successfully added item to cart.',
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          cart.removeSingleItem(productItem.id!);
                        }),
                  ));
                },
              ),
              title: Text(
                productItem.title,
                textAlign: TextAlign.center,
              )),
          child: GestureDetector(
            onTap: () => selectProduct(context, productItem.id!),
            child: Image.network(
              productItem.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
