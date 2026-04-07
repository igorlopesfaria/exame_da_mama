import 'package:feature_register/presentation/pages/password/cubit/register_password_cubit.dart';
import 'package:feature_register/presentation/pages/password/widget/register_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterPasswordScreen extends StatelessWidget {
  const RegisterPasswordScreen({
    super.key,
    required this.cpf,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.birthdate,
    required this.onComplete,
  });

  final String cpf;
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String birthdate;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterPasswordCubit>(),
      child: _RegisterPasswordView(onComplete: onComplete),
    );
  }
}

class _RegisterPasswordView extends StatelessWidget {
  const _RegisterPasswordView({required this.onComplete});

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterPasswordWidget(
      onContinue: onComplete, // Value to be wired with cubit
    );
  }
}
