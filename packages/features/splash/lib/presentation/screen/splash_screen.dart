import 'package:commons_navigation/navigator/app_navigator.dart';
import 'package:commons_navigation/route/app_paths.dart';
import 'package:feature_splash/presentation/cubit/splash_cubit.dart';
import 'package:feature_splash/presentation/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SplashCubit>()..checkSession(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          _navigate(context, state.to);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: const SizedBox.expand(),
      ),
    );
  }

  void _navigate(BuildContext context, SplashDestination destination) {
    switch (destination) {
      case SplashDestination.home:
        AppNavigator.pushNamedAndClear(context, AppPaths.homeRoute);
      case SplashDestination.welcome:
        AppNavigator.pushNamedAndClear(context, AppPaths.initializationRoute);
      case SplashDestination.terms:
        AppNavigator.pushNamedAndClear(context, AppPaths.termsRoute);
      case SplashDestination.force_update:
        AppNavigator.pushNamedAndClear(context, AppPaths.forceUpdateRoute);
    }
  }
}
