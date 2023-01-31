import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  // Future _obtainOrdersFuture() {
  //   return Provider.of<Orders>(context, listen: false).fetchOrders();
  // }

  @override
  void initState() {
    _ordersFuture = Provider.of<Orders>(context, listen: false).fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) => orderData.orders.isEmpty
                    ? const Center(
                        child: Text('No Orders Found.'),
                      )
                    : ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, index) => OrderItem(
                              order: orderData.orders[index],
                            )),
              );
            }
          }
        },
      ),
    );
  }
}
