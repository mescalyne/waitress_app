import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:waitress_app/resources/app_theme.dart';
import 'package:waitress_app/resources/localization.dart';

class TableWidget extends StatelessWidget {
  final int tableNumber;
  final String image;
  final bool isOccupy;
  final Function onAddProducts;
  final Function onCheckOrder;
  final double width;

  const TableWidget({
    super.key,
    required this.tableNumber,
    required this.image,
    required this.isOccupy,
    required this.onAddProducts,
    required this.onCheckOrder,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final tooltipController = SuperTooltipController();

    return SuperTooltip(
      controller: tooltipController,
      content: Material(
        elevation: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                onAddProducts();
                tooltipController.hideTooltip();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.theme.container3,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  context.localize('addMore'),
                  style: TextStyle(
                    color: context.theme.text2,
                    fontSize: 14,
                    fontFamily: 'Bantayog',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                onCheckOrder();
                tooltipController.hideTooltip();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.theme.accentColor1,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  context.localize('check'),
                  style: TextStyle(
                    color: context.theme.text2,
                    fontSize: 14,
                    fontFamily: 'Bantayog',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (isOccupy) {
            tooltipController.showTooltip();
          } else {
            onAddProducts();
          }
        },
        child: Image.asset(
          'assets/elements/$image.png',
          color: isOccupy ? context.theme.container4 : context.theme.container1,
          width: width,
        ),
      ),
    );
  }
}
