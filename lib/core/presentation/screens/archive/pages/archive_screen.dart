import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waitress_app/core/presentation/screens/archive/bloc/bloc.dart';
import 'package:waitress_app/core/presentation/screens/archive/bloc/state.dart';
import 'package:waitress_app/core/presentation/screens/archive/widgets/main_widget.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchiveScreenBloc, ArchiveScreenState>(
        builder: (context, state) {
      switch (state) {
        case MainArchiveScreenState(
            :final productKeys,
            :final orders,
          ):
          return MainArchiveWidget(
            products: productKeys,
            orders: orders,
          );
        default:
          return const CircularProgressIndicator();
      }
    });
  }
}
