import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/bloc.dart';
import 'package:waitress_app/core/presentation/screens/welcome/bloc/state.dart';
import 'package:waitress_app/core/presentation/screens/welcome/widgets/main_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeScreenBloc, WelcomeScreenState>(
        builder: (context, state) {
      switch (state) {
        case MainWelcomeScreenState(
            :final products,
            :final orders,
          ):
          return MainWidget(
            products: products,
            orders: orders,
          );
        default:
          return const CircularProgressIndicator();
      }
    });
  }
}
