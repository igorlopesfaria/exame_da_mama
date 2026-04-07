import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_cubit.dart';
import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_state.dart';
import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCpfWidget extends StatefulWidget {
  const RegisterCpfWidget({super.key});

  @override
  State<RegisterCpfWidget> createState() => _RegisterCpfWidgetState();
}

class _RegisterCpfWidgetState extends State<RegisterCpfWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = RegisterCpfLocalizations.of(context);
    final cubit = context.read<RegisterCpfCubit>();

    return BlocBuilder<RegisterCpfCubit, RegisterCpfState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            FloraSpacing.s4,
            FloraSpacing.s4,
            FloraSpacing.s4,
            FloraSpacing.s4 + MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FloraText.titleLarge(l10n.title),
              const SizedBox(height: FloraSpacing.s2),
              FloraText.bodyMedium(l10n.description),
              const SizedBox(height: FloraSpacing.s6),
              FloraTextField(
                label: l10n.cpfLabel,
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                errorText: state.isInvalidField ? l10n.errorInvalidCpf : null,
                onChanged: cubit.onCpfChanged,
                enabled: !state.isLoading,
              ),
              const Spacer(),
              FloraButton(
                label: l10n.continueButton,
                onPressed: state.isButtonEnabled && !state.isLoading ? cubit.submit : null,
                isLoading: state.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}
