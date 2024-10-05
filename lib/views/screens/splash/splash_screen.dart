import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';
import 'package:team_sphere_mobile/views/screens/auth/cubit/login_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.go('/login');
        }
        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                Assets.images.logo.path,
                height: 120,
                width: 160,
              ),
            ),
            // UpdateVersionProvider(packageInformation: packageInformation),
          ],
        ),
      ),
    );
  }
}
