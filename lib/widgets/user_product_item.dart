import 'package:flutter/material.dart';

import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function deleteProduct;

  const UserProductItem(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.deleteProduct,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {
                  deleteProduct(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                )),
          ],
        ),
      ),
    );
  }
}
