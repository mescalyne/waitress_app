import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:waitress_app/core/data/storage.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/bloc.dart';
import 'package:waitress_app/core/presentation/screens/welcome/pages/welcome_screen.dart';
import 'package:waitress_app/injection/injection.dart';
import 'package:waitress_app/resources/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await setupApp();
  runApp(const MyApp());
}


Future<void> setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorageImpl.init();
  await configureInjection(Environment.test);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
      ],
      localizationsDelegates: <LocalizationsDelegate>[
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            fallbackFile: 'en',
            basePath: 'assets/locales',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      navigatorKey: navigatorKey,
      home: BlocProvider<WelcomeScreenBloc>(
        create: (_) => getIt<WelcomeScreenBloc>(),
        child: const WelcomeScreen(),
      ),
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          AutoTheme.lightTheme,
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          AutoTheme.darkTheme,
        ],
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
