import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_sphere_mobile/app/routes/router.dart';
import 'package:team_sphere_mobile/config.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';
import 'package:team_sphere_mobile/views/providers/global_state_provider.dart';

void main() async {
  String supabaseUrlKey = Config.supabaseKey;
  String supabaseAnonKey = Config.supabaseAnonKey;

  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Supabase.initialize(
      url: supabaseUrlKey,
      anonKey: supabaseAnonKey,
    ),
    configureDependencies(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
       const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return GlobalStateProvider(
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(),
      ),
    );
  }
}
