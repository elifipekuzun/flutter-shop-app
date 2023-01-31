import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as oi;

class OrderItem extends StatefulWidget {
  final oi.OrderItem order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _isExpanded
          ? min(widget.order.products.length * 20.0 + 120, 200)
          : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: _isExpanded
                  ? min(widget.order.products.length * 20.0 + 20, 100)
                  : 0,
              child: ListView(
                children: widget.order.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${prod.quantity}x \$${prod.price}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
