import 'package:feature_register/presentation/cubit/register_cubit.dart';
import 'package:feature_register/presentation/cubit/register_state.dart';
import 'package:feature_register/presentation/pages/birthdate/screen/register_birthdate_screen.dart';
import 'package:feature_register/presentation/pages/birthdate/string/register_birthdate_localizations.dart';
import 'package:feature_register/presentation/pages/cpf/screen/register_cpf_screen.dart';
import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations.dart';
import 'package:feature_register/presentation/pages/email/screen/register_email_screen.dart';
import 'package:feature_register/presentation/pages/email/string/register_email_localizations.dart';
import 'package:feature_register/presentation/pages/gender/screen/register_gender_screen.dart';
import 'package:feature_register/presentation/pages/gender/string/register_gender_localizations.dart';
import 'package:feature_register/presentation/pages/name/screen/register_name_screen.dart';
import 'package:feature_register/presentation/pages/name/string/register_name_localizations.dart';
import 'package:feature_register/presentation/pages/password/screen/register_password_screen.dart';
import 'package:feature_register/presentation/pages/password/string/register_password_localizations.dart';
import 'package:feature_register/presentation/pages/phone/screen/register_phone_screen.dart';
import 'package:feature_register/presentation/pages/phone/string/register_phone_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<RegisterCubit>(),
      child: Localizations.override(
        context: context,
        delegates: const [
          RegisterCpfLocalizations.delegate,
          RegisterNameLocalizations.delegate,
          RegisterPhoneLocalizations.delegate,
          RegisterEmailLocalizations.delegate,
          RegisterGenderLocalizations.delegate,
          RegisterBirthdateLocalizations.delegate,
          RegisterPasswordLocalizations.delegate,
        ],
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  bool _isForward = true;
  int _previousStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (prev, curr) => prev.currentStep != curr.currentStep,
      listener: (context, state) {
        setState(() {
          _isForward = state.currentStep > _previousStep;
          _previousStep = state.currentStep;
        });
      },
      builder: (context, state) {
        return Scaffold(
          appBar: FloraAppBar(
            currentStep: state.currentStep + 1,
            totalSteps: RegisterState.totalSteps,
            leadingFlutterIcon: Icons.arrow_back_outlined,
            onLeadingPressed: () =>
                context.read<RegisterCubit>().previousStep(),

            automaticallyImplyLeading: state.currentStep > 0,
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              final begin = _isForward
                  ? const Offset(1.0, 0.0)
                  : const Offset(-1.0, 0.0);
              return SlideTransition(
                position: Tween<Offset>(begin: begin, end: Offset.zero)
                    .animate(animation),
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey(state.currentStep),
              child: _buildPage(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, RegisterState state) {
    final cubit = context.read<RegisterCubit>();
    return switch (state.currentStep) {
      0 => RegisterCpfScreen(
          onComplete: cubit.completeCpf,
        ),
      1 => RegisterNameScreen(
          cpf: state.cpf!,
          onComplete: cubit.completeName,
        ),
      2 => RegisterPhoneScreen(
          cpf: state.cpf!,
          name: state.name!,
          onComplete: cubit.completePhone,
        ),
      3 => RegisterEmailScreen(
          cpf: state.cpf!,
          name: state.name!,
          phone: state.phone!,
          onComplete: cubit.completeEmail,
        ),
      4 => RegisterGenderScreen(
          cpf: state.cpf!,
          name: state.name!,
          phone: state.phone!,
          email: state.email!,
          onComplete: cubit.completeGender,
        ),
      5 => RegisterBirthdateScreen(
          cpf: state.cpf!,
          name: state.name!,
          phone: state.phone!,
          email: state.email!,
          gender: state.gender!,
          onComplete: cubit.completeBirthdate,
        ),
      6 => RegisterPasswordScreen(
          cpf: state.cpf!,
          name: state.name!,
          phone: state.phone!,
          email: state.email!,
          gender: state.gender!,
          birthdate: state.birthdate!,
          onComplete: () {
            // Final submission — to be implemented
          },
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
