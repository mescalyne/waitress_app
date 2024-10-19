import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:waitress_app/core/domain/entities/orders.dart';
import 'package:waitress_app/core/domain/entities/product.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/bloc.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/event.dart';
import 'package:waitress_app/core/presentation/widgets/menu_popup.dart';
import 'package:waitress_app/core/presentation/screens/welcome/widgets/table_widget.dart';
import 'package:waitress_app/core/presentation/widgets/order_popup.dart';
import 'package:waitress_app/main.dart';
import 'package:waitress_app/resources/app_theme.dart';
import 'package:waitress_app/resources/localization.dart';
import 'package:waitress_app/resources/router.dart';

class MainWidget extends StatelessWidget {
  final List<Product> products;
  final Map<int, TableOrder> orders;

  const MainWidget({
    super.key,
    required this.orders,
    required this.products,
  });

  void onAddProducts(int tableNumber, BuildContext upperContext) {
    showDialog(
      barrierDismissible: true,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return MenuPopup(
          products: products,
          onConfirm: (choosenProductIds) {
            BlocProvider.of<WelcomeScreenBloc>(upperContext)
                .add(AddProductsToTableEvent(
              choosenProductIds: choosenProductIds,
              tableNumber: tableNumber,
            ));
          },
        );
      },
    );
  }

  void onCheckOrder(int tableNumber, BuildContext upperContext) {
    final tableOrder = orders[tableNumber];
    if (tableOrder != null) {
      final productKeys = {for (var product in products) product.id: product};
      List<Product> productsInOrder = [];
      for (var id in tableOrder.productIds) {
        if (productKeys[id] != null) {
          productsInOrder.add(productKeys[id]!);
        }
      }

      showDialog(
        barrierDismissible: true,
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          final date = DateFormat('dd MMM yy HH:mm').format(
              DateTime.fromMillisecondsSinceEpoch(tableOrder.timestamp));
          final details =
              'Table #$tableNumber, Status: ${tableOrder.isActive ? 'Active' : 'Inactive'}, Date: $date';

          return OrderPopup(
            details: details,
            productsInOrder: productsInOrder,
            onFinishTable: () {
              BlocProvider.of<WelcomeScreenBloc>(upperContext)
                  .add(CancelTableEvent(tableNumber: tableNumber));
            },
          );
        },
      );
    }
  }

  static const Map<int, String> _tables = {
    1: "table1",
    2: "table2",
    3: "table3",
    4: "table1",
    5: "table2",
    6: "table3",
  };

  @override
  Widget build(BuildContext context) {
    final tableWidth = MediaQuery.of(context).size.width / 3.6;

    return Scaffold(
      backgroundColor: context.theme.background1,
      appBar: AppBar(
        title: Text(
          context.localize('mainAppBar'),
          style: TextStyle(
            color: context.theme.text1,
            fontSize: 20,
            fontFamily: 'Bantayog',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(AppRouter.archive());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Icon(
                CupertinoIcons.archivebox,
                color: context.theme.container1,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 40,
              children: _tables.entries.map((e) {
                final tableNumber = e.key;

                return TableWidget(
                  tableNumber: tableNumber,
                  image: e.value,
                  isOccupy: orders[tableNumber] != null,
                  onAddProducts: () => onAddProducts(tableNumber, context),
                  onCheckOrder: () => onCheckOrder(tableNumber, context),
                  width: tableWidth,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
