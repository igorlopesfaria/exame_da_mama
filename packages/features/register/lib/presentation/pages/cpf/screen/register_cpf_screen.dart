import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_cubit.dart';
import 'package:feature_register/presentation/pages/cpf/widget/register_cpf_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterCpfScreen extends StatelessWidget {
  const RegisterCpfScreen({super.key, required this.onComplete});

  final void Function(String cpf) onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterCpfCubit>(),
      child: _RegisterCpfView(onComplete: onComplete),
    );
  }
}

class _RegisterCpfView extends StatelessWidget {
  const _RegisterCpfView({required this.onComplete});

  final void Function(String cpf) onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterCpfWidget(
      onContinue: () => onComplete(''), // Value to be wired with cubit
    );
  }
}
