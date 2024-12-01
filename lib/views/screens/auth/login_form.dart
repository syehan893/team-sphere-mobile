import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
              child: H2(
            'Hai, selamat datang lagi!',
            color: TSColors.primary.p100,
          )),
          const SizedBox(height: 8),
          Center(
              child: SubHeadline.regular(
            'Ayo mulai pengalamanmu dengan Team Sphere',
            textAlign: TextAlign.center,
            color: TSColors.shades.loEm,
          )),
          const SizedBox(height: 20),
          TextInput(
            margin: const EdgeInsets.only(top: 20),
            controller: emailController,
            label: 'Email',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (Util.falsyChecker(value)) {
                return 'Email cannot be empty';
              }
              return null;
            },
            hintText: 'Email',
          ),
          const SizedBox(height: 12),
          TextInput(
            controller: passwordController,
            label: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if ((value?.length ?? 0) < 8) {
                return 'Password at least 8 character';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Password',
          ),
        ],
      ),
    );
  }
}
