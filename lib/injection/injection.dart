import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

abstract class _AppEnviroment {
  String call();
}

class _AppEnviromentImpl extends _AppEnviroment {
  final String env;

  _AppEnviromentImpl({required this.env});

  @override
  String call() => env;
}

final appEnviroment = getIt.get<_AppEnviroment>();

@InjectableInit()
Future<void> configureInjection(String environment) async {
  getIt.init(environment: environment);
  getIt.registerSingleton<_AppEnviroment>(_AppEnviromentImpl(env: environment));
}
