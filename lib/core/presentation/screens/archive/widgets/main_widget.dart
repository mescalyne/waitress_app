import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:waitress_app/core/domain/entities/orders.dart';
import 'package:waitress_app/core/domain/entities/product.dart';
import 'package:waitress_app/core/presentation/widgets/order_popup.dart';
import 'package:waitress_app/main.dart';
import 'package:waitress_app/resources/app_theme.dart';
import 'package:waitress_app/resources/localization.dart';

class MainArchiveWidget extends StatelessWidget {
  final List<TableOrder> orders;
  final Map<String, Product> products;

  const MainArchiveWidget({
    super.key,
    required this.orders,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localize('archive'),
          style: TextStyle(
            color: context.theme.text1,
            fontSize: 20,
            fontFamily: 'Bantayog',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return GestureDetector(
              onTap: () {
                List<Product> productsInOrder = [];
                for (var id in order.productIds) {
                  if (products[id] != null) {
                    productsInOrder.add(products[id]!);
                  }
                }

                showDialog(
                  barrierDismissible: true,
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    final date = DateFormat('dd MMM yy HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(order.timestamp));
                    final details =
                        'Table #${order.tableNumber}, Status: ${order.isActive ? 'Active' : 'Inactive'}, Date: $date';

                    return OrderPopup(
                      details: details,
                      productsInOrder: productsInOrder,
                    );
                  },
                );
              },
              child: ListElementWidget(order: order));
        },
      ),
    );
  }
}

class ListElementWidget extends StatelessWidget {
  final TableOrder order;

  const ListElementWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yy, HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(order.timestamp));

    return Container(
      decoration: BoxDecoration(
          color: context.theme.background3,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date.toString(),
            style: TextStyle(
              color: context.theme.text1,
              fontSize: 16,
              fontFamily: 'Bantayog',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Table #${order.tableNumber.toString()}',
            style: TextStyle(
              color: context.theme.text1,
              fontSize: 12,
              fontFamily: 'Bantayog',
            ),
          ),
        ],
      ),
    );
  }
}
