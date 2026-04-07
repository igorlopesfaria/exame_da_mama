import 'package:feature_register/presentation/pages/phone/cubit/register_phone_cubit.dart';
import 'package:feature_register/presentation/pages/phone/widget/register_phone_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterPhoneScreen extends StatelessWidget {
  const RegisterPhoneScreen({
    super.key,
    required this.cpf,
    required this.name,
    required this.onComplete,
  });

  final String cpf;
  final String name;
  final void Function(String phone) onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterPhoneCubit>(),
      child: _RegisterPhoneView(onComplete: onComplete),
    );
  }
}

class _RegisterPhoneView extends StatelessWidget {
  const _RegisterPhoneView({required this.onComplete});

  final void Function(String phone) onComplete;

  @override
  Widget build(BuildContext context) {
    return RegisterPhoneWidget(
      onContinue: () => onComplete(''), // Value to be wired with cubit
    );
  }
}
