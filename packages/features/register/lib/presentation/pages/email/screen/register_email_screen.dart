import 'package:feature_register/presentation/pages/email/cubit/register_email_cubit.dart';
import 'package:feature_register/presentation/pages/email/widget/register_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterEmailScreen extends StatelessWidget {
  const RegisterEmailScreen({
    super.key,
    required this.cpf,
    required this.name,
    required this.phone,
    required this.onComplete,
  });

  final String cpf;
  final String name;
  final String phone;
  final void Function(String email) onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterEmailCubit>(),
      child: _RegisterEmailView(onComplete: onComplete),
    );
  }
}

class _RegisterEmailView extends StatelessWidget {
  const _RegisterEmailView({required this.onComplete});

  final void Function(String email) onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterEmailWidget(
      onContinue: () => onComplete(''), // Value to be wired with cubit
    );
  }
}
