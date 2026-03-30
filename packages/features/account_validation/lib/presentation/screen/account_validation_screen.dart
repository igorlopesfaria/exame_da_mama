import 'package:commons_navigation/navigator/app_navigator.dart';
import 'package:commons_navigation/route/app_paths.dart';
import 'package:feature_account_validation/presentation/cubit/account_validation_cubit.dart';
import 'package:feature_account_validation/presentation/cubit/account_validation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AccountValidationScreen extends StatelessWidget {
  const AccountValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<AccountValidationCubit>()..validate(),
      child: const _AccountValidationView(),
    );
  }
}

class _AccountValidationView extends StatelessWidget {
  const _AccountValidationView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountValidationCubit, AccountValidationState>(
      listener: (context, state) {
        if (state is AccountValidationSuccess) {
          AppNavigator.pushNamedAndClear(context, AppPaths.homeRoute);
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
