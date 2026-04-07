import 'package:feature_register/presentation/pages/gender/cubit/register_gender_cubit.dart';
import 'package:feature_register/presentation/pages/gender/widget/register_gender_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterGenderScreen extends StatelessWidget {
  const RegisterGenderScreen({
    super.key,
    required this.cpf,
    required this.name,
    required this.phone,
    required this.email,
    required this.onComplete,
  });

  final String cpf;
  final String name;
  final String phone;
  final String email;
  final void Function(String gender) onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterGenderCubit>(),
      child: _RegisterGenderView(onComplete: onComplete),
    );
  }
}

class _RegisterGenderView extends StatelessWidget {
  const _RegisterGenderView({required this.onComplete});

  final void Function(String gender) onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterGenderWidget(
      onContinue: () => onComplete(''), // Value to be wired with cubit
    );
  }
}
