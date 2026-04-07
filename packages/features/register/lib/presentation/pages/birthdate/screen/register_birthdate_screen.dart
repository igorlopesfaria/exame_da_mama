import 'package:feature_register/presentation/pages/birthdate/cubit/register_birthdate_cubit.dart';
import 'package:feature_register/presentation/pages/birthdate/widget/register_birthdate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterBirthdateScreen extends StatelessWidget {
  const RegisterBirthdateScreen({
    super.key,
    required this.cpf,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.onComplete,
  });

  final String cpf;
  final String name;
  final String phone;
  final String email;
  final String gender;
  final void Function(String birthdate) onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterBirthdateCubit>(),
      child: _RegisterBirthdateView(onComplete: onComplete),
    );
  }
}

class _RegisterBirthdateView extends StatelessWidget {
  const _RegisterBirthdateView({required this.onComplete});

  final void Function(String birthdate) onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterBirthdateWidget(
      onContinue: () => onComplete(''), // Value to be wired with cubit
    );
  }
}
