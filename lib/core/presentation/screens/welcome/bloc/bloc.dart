import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:waitress_app/core/data/storage.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/event.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/state.dart';

@Injectable()
class WelcomeScreenBloc extends Bloc<WelcomeScreenEvent, WelcomeScreenState> {
  final AppStorage storage;

  WelcomeScreenBloc({
    required this.storage,
  }) : super(LoadingWelcomeScreenState()) {
    on<InitialWelcomeEvent>((event, emit) async {
      final products = await storage.getAllProducts();
      final orders = await storage.getActiveTableOrder();
      emit(MainWelcomeScreenState(
        products: products,
        orders: orders,
      ));
    });

    on<AddProductsToTableEvent>((event, emit) async {
      if (state is MainWelcomeScreenState) {
        final currState = state as MainWelcomeScreenState;
        final tableNumber = event.tableNumber;
        final currOrder = currState.orders[tableNumber];
        bool result = false;
        if (currOrder == null) {
          result = await storage.createNewOrder(
              tableNumber: tableNumber,
              choosenProductIds: event.choosenProductIds);
        } else {
          result = await storage.addProductsToTable(
            tableNumber: tableNumber,
            choosenProductIds: event.choosenProductIds,
          );
        }
        if (result) {
          final orders = await storage.getActiveTableOrder();
          emit(currState.copyWith(orders: orders));
        }
      }
    });
    on<CancelTableEvent>((event, emit) async {
      if (state is MainWelcomeScreenState) {
        final currState = state as MainWelcomeScreenState;
        final tableNumber = event.tableNumber;
        final currOrder = currState.orders[tableNumber];
        if (currOrder != null) {
          final result =
              await storage.setTableInactive(tableNumber: tableNumber);

          if (result) {
            final orders = await storage.getActiveTableOrder();
            emit(currState.copyWith(orders: orders));
          }
        }
      }
    });

    add(InitialWelcomeEvent());
  }
}
