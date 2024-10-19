class TableOrder {
  final int timestamp;
  final int tableNumber;
  final bool isActive;
  final List<String> productIds;

  TableOrder({
    required this.timestamp,
    required this.tableNumber,
    required this.isActive,
    required this.productIds,
  });

  factory TableOrder.fromMap(Map<String, dynamic> map) {
    return TableOrder(
      timestamp: map['timestamp'],
      tableNumber: map['table_number'],
      isActive: map['is_active'] == 1,
      productIds: map['product_ids'] != null
          ? map['product_ids'].split(',').toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'table_number': tableNumber,
      'is_active': isActive ? 1 : 0,
      'product_ids': productIds.join(','),
    };
  }
}
