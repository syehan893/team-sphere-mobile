import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/views/screens/auth/login_form.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../../cubits/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Masuk',
      onBackTap: () {
        Navigator.pop(context);
      },
      backgroundColor: TSColors.background.b100,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: LoadingAnimationWidget.progressiveDots(
                    color: TSColors.primary.p100,
                    size: 50,
                  ),
                );
              },
            );
          }
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Authentication successful')),
            );
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error?.message ?? '')),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: LoginForm(
              emailController: emailController,
              passwordController: passwordController,
            ),
          );
        },
      ),
      footer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Button(
          width: MediaQuery.of(context).size.width - 48,
          title: 'Login',
          titelStyle: const TextStyle(fontWeight: FontWeight.bold),
          onTap: () {
            final isValid = _formKey.currentState!.validate();
            final email = emailController.text;
            final password = passwordController.text;
            if (isValid) {
              context.read<AuthCubit>().signIn(email, password);
            }
          },
          titleColor: TSColors.background.b100,
        ),
      ),
    );
  }
}
