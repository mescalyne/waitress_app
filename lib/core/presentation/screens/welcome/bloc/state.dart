import 'package:waitress_app/core/domain/entities/orders.dart';
import 'package:waitress_app/core/domain/entities/product.dart';

sealed class WelcomeScreenState {}

class LoadingWelcomeScreenState extends WelcomeScreenState {}

class MainWelcomeScreenState extends WelcomeScreenState {
  final List<Product> products;
  final Map<int, TableOrder> orders;

  MainWelcomeScreenState({
    required this.products,
    required this.orders,
  });

  MainWelcomeScreenState copyWith({
    List<Product>? products,
    Map<int, TableOrder>? orders,
  }) {
    return MainWelcomeScreenState(
      products: products ?? this.products,
      orders: orders ?? this.orders,
    );
  }
}
