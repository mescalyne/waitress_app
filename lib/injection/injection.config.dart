// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:waitress_app/core/data/storage.dart' as _i1020;
import 'package:waitress_app/core/presentation/screens/archive/bloc/bloc.dart'
    as _i757;
import 'package:waitress_app/core/presentation/screens/welcome/bloc/bloc.dart'
    as _i505;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1020.AppStorage>(() => _i1020.AppStorageImpl());
    gh.factory<_i757.ArchiveScreenBloc>(
        () => _i757.ArchiveScreenBloc(storage: gh<_i1020.AppStorage>()));
    gh.factory<_i505.WelcomeScreenBloc>(
        () => _i505.WelcomeScreenBloc(storage: gh<_i1020.AppStorage>()));
    return this;
  }
}
