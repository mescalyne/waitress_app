import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:waitress_app/core/presentation/screens/archive/bloc/bloc.dart';
import 'package:waitress_app/core/presentation/screens/archive/pages/archive_screen.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/bloc.dart';
import 'package:waitress_app/core/presentation/screens/welcome/pages/welcome_screen.dart';
import 'package:waitress_app/injection/injection.dart';

class AppRouter {
  static CupertinoPageRoute welcome() => CupertinoPageRoute(
        settings: const RouteSettings(name: 'welcome'),
        builder: (context) => BlocProvider<WelcomeScreenBloc>(
          create: (_) => getIt<WelcomeScreenBloc>(),
          child: const WelcomeScreen(),
        ),
      );

  static CupertinoPageRoute archive() => CupertinoPageRoute(
        settings: const RouteSettings(name: 'archive'),
        builder: (context) => BlocProvider<ArchiveScreenBloc>(
          create: (_) => getIt<ArchiveScreenBloc>(),
          child: const ArchiveScreen(),
        ),
      );
}
