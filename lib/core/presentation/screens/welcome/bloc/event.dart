abstract class WelcomeScreenEvent {}

class InitialWelcomeEvent extends WelcomeScreenEvent {}

class AddProductsToTableEvent extends WelcomeScreenEvent {
  final int tableNumber;
  final List<String> choosenProductIds;

  AddProductsToTableEvent({
    required this.tableNumber,
    required this.choosenProductIds,
  });
}

class CancelTableEvent extends WelcomeScreenEvent {
  final int tableNumber;

  CancelTableEvent({
    required this.tableNumber,
  });
}
