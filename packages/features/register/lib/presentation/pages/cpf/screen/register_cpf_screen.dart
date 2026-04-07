import 'package:commons_infra/failures/app_failures.dart';
import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_cubit.dart';
import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_state.dart';
import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations.dart';
import 'package:feature_register/presentation/pages/cpf/widget/register_cpf_widget.dart';
import 'package:flora/flora.dart';
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

  String _errorMessage(BuildContext context, Failure failure) {
    final l10n = RegisterCpfLocalizations.of(context);
    return switch (failure) {
      NetworkFailure() => l10n.errorNoInternet,
      _ => l10n.errorGeneric,
    };
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCpfCubit>();

    return BlocListener<RegisterCpfCubit, RegisterCpfState>(
      listenWhen: (prev, curr) => prev.validationState != curr.validationState,
      listener: (context, state) {
        switch (state.validationState) {
          case RegisterCpfValidationSuccess(:final cpf):
            onComplete(cpf);
          case RegisterCpfValidationError(:final failure):
            FloraToast.show(
              context,
              position: FloraToastPosition.top,
              message: _errorMessage(context, failure),
              variant: FloraToastVariant.error,
            );
            cubit.resetValidation();
          default:
            break;
        }
      },
      child: const RegisterCpfWidget(),
    );
  }
}
