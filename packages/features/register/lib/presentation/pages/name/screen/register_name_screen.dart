import 'package:feature_register/presentation/pages/name/cubit/register_name_cubit.dart';
import 'package:feature_register/presentation/pages/name/widget/register_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterNameScreen extends StatelessWidget {
  const RegisterNameScreen({
    super.key,
    required this.cpf,
    required this.onComplete,
  });

  final String cpf;
  final void Function(String name) onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterNameCubit>(),
      child: _RegisterNameView(onComplete: onComplete),
    );
  }
}

class _RegisterNameView extends StatelessWidget {
  const _RegisterNameView({required this.onComplete});

  final void Function(String name) onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterNameWidget(
      onContinue: () => onComplete(''), // Value to be wired with cubit
    );
  }
}
