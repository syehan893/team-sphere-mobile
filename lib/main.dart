import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';
import 'package:team_sphere_mobile/views/screens/auth/cubit/login_cubit.dart';
import 'package:team_sphere_mobile/views/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Supabase.initialize(
      url: 'https://gqrrkswdhnhahfvgjzkj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdxcnJrc3dkaG5oYWhmdmdqemtqIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNDg1ODk3NSwiZXhwIjoyMDQwNDM0OTc1fQ.j28iabgnc4hJwOD0EC_QsV2DnLk0UYelPm6FAfU4fAU',
    ),
    configureDependencies(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const AuthView(),
      ),
    );
  }
}