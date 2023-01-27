import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    final orders = ordersData.orders;
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (ctx, index) => OrderItem(
                order: orders[index],
              )),
    );
  }
}
