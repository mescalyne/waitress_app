import 'package:flutter/material.dart';
import 'package:waitress_app/core/domain/entities/product.dart';
import 'package:waitress_app/resources/app_theme.dart';
import 'package:waitress_app/resources/localization.dart';

class MenuPopup extends StatefulWidget {
  final List<Product> products;
  final Function(List<String>) onConfirm;

  const MenuPopup({
    super.key,
    required this.products,
    required this.onConfirm,
  });

  @override
  State<MenuPopup> createState() => _MenuPopupState();
}

class _MenuPopupState extends State<MenuPopup> {
  List<String> choosenProducts = [];

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
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final elementWidth = constraints.maxWidth / 3;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localize('chooseProducts'),
                  style: TextStyle(
                    color: context.theme.text1,
                    fontSize: 18,
                    fontFamily: 'Bantayog',
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  runSpacing: 30.0,
                  children: widget.products.map((el) {
                    final indx = choosenProducts
                        .indexWhere((product) => el.id == product);

                    return MenuElementWidget(
                      onTap: (productId) {
                        setState(() {
                          if (indx == -1) {
                            choosenProducts.add(productId);
                          } else {
                            choosenProducts.remove(productId);
                          }
                        });
                      },
                      width: elementWidth,
                      product: el,
                      isChoosen: indx != -1,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    widget.onConfirm(choosenProducts);
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
                      context.localize('addToOrder'),
                      style: TextStyle(
                        color: context.theme.text1,
                        fontSize: 18,
                        fontFamily: 'Bantayog',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class MenuElementWidget extends StatelessWidget {
  final Product product;
  final double width;
  final Function onTap;
  final bool isChoosen;

  const MenuElementWidget({
    super.key,
    required this.product,
    required this.width,
    required this.onTap,
    required this.isChoosen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(product.id),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: isChoosen ? context.theme.container2 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Image.asset(
                'assets/products/${product.filename}',
                width: width * 0.5,
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
        ),
      ),
    );
  }
}
