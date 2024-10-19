import 'package:flutter/material.dart';
import 'package:waitress_app/core/domain/entities/product.dart';
import 'package:waitress_app/resources/app_theme.dart';
import 'package:waitress_app/resources/localization.dart';

class OrderPopup extends StatelessWidget {
  final String details;
  final List<Product> productsInOrder;
  final Function? onFinishTable;

  const OrderPopup({
    super.key,
    required this.details,
    required this.productsInOrder,
    this.onFinishTable,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.theme.background2,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 20,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                context.localize('orderDetails'),
                style: TextStyle(
                  color: context.theme.text1,
                  fontSize: 18,
                  fontFamily: 'Bantayog',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                details,
                style: TextStyle(
                  color: context.theme.text3,
                  fontSize: 12,
                  fontFamily: 'Bantayog',
                ),
              ),
              const SizedBox(height: 40),
              ...productsInOrder.map((e) => ListElementWidget(product: e)),
              const SizedBox(height: 40),
              onFinishTable != null
                  ? GestureDetector(
                      onTap: () {
                        onFinishTable?.call();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: context.theme.container3,
                        ),
                        child: Text(
                          context.localize('finishTable'),
                          style: TextStyle(
                            color: context.theme.text1,
                            fontSize: 18,
                            fontFamily: 'Bantayog',
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListElementWidget extends StatelessWidget {
  final Product product;

  const ListElementWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Image.asset(
            'assets/products/${product.filename}',
            width: 40,
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
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
