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
            color: PColors.primary.p100,
          )),
          const SizedBox(height: 8),
          Center(
              child: SubHeadline.regular(
            'Ayo mulai pengalamanmu dengan Team Sphere',
            textAlign: TextAlign.center,
            color: PColors.shades.loEm,
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
                return 'Email is not valid';
              }
              return null;
            },
            hintText: 'Email',
          ),
          const SizedBox(height: 12),
          TextInput.password(
            controller: passwordController,
            label: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onVisibilityTap: () {},
            hintText: 'Password',
          ),
        ],
      ),
    );
  }
}
