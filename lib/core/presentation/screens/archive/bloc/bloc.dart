import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:waitress_app/core/data/storage.dart';
import 'package:waitress_app/core/presentation/screens/archive/bloc/event.dart';
import 'package:waitress_app/core/presentation/screens/archive/bloc/state.dart';

@Injectable()
class ArchiveScreenBloc extends Bloc<ArchiveScreenEvent, ArchiveScreenState> {
  final AppStorage storage;

  ArchiveScreenBloc({
    required this.storage,
  }) : super(LoadingArchiveScreenState()) {
    on<InitArchiveScreenEvent>(
      (event, emit) async {
        final orders = await storage.getInactiveTableOrder();
        final productList = await storage.getAllProducts();
        final productKeys = {
          for (var product in productList) product.id: product
        };

        emit(MainArchiveScreenState(
          orders: orders,
          productKeys: productKeys,
        ));
      },
    );

    add(InitArchiveScreenEvent());
  }
}
