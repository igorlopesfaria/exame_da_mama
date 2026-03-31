import 'package:commons_navigation/commons_navigation.dart';
import 'package:feature_initialization/presentation/cubit/initialization_cubit.dart';
import 'package:feature_initialization/presentation/cubit/initialization_state.dart';
import 'package:feature_initialization/presentation/widget/initialization_buttons.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class InitializationScreen extends StatelessWidget {
  const InitializationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<InitializationCubit>(),
      child: const _InitializationView(),
    );
  }
}

class _InitializationView extends StatelessWidget {
  const _InitializationView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitializationCubit, InitializationState>(
      listener: (context, state) {
        if (state is InitializationNavigate) {
          switch (state.to) {
            case InitializationDestination.register:
              AppNavigator.pushNamed(context, AppPaths.registerRoute);
            case InitializationDestination.login:
              AppNavigator.pushNamed(context, AppPaths.loginRoute);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(),
              FloraImage.asset(FloraImageAssets.imgInitialization),
              const InitializationButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
