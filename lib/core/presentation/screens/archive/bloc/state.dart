import 'package:waitress_app/core/domain/entities/orders.dart';
import 'package:waitress_app/core/domain/entities/product.dart';

sealed class ArchiveScreenState {}

class LoadingArchiveScreenState extends ArchiveScreenState {}

class MainArchiveScreenState extends ArchiveScreenState {
  final List<TableOrder> orders;
  final Map<String, Product> productKeys;

  MainArchiveScreenState({
    required this.productKeys,
    required this.orders,
  });
}
