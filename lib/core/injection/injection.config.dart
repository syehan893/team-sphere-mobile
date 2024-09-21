// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../data/data.dart' as _i388;
import '../../data/datasources/datasources.dart' as _i905;
import '../../data/datasources/local/shared_preferences_datasource.dart'
    as _i648;
import '../../data/datasources/remote/supbase__auth_datasource.dart' as _i642;
import '../../data/repositories/auth_repository.dart' as _i481;
import '../../views/screens/auth/cubit/login_cubit.dart' as _i561;
import '../network/api_client.dart' as _i557;
import '../network/auth_interceptor.dart' as _i908;
import '../network/network.dart' as _i855;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> $initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.singleton<_i648.SessionManager>(() => _i648.SessionManager());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i642.SupabaseAuthDatasource>(
        () => _i642.SupabaseAuthDatasource(gh<_i454.SupabaseClient>()));
    gh.singleton<_i908.AuthService>(() => _i908.AuthService(
          gh<_i454.SupabaseClient>(),
          gh<_i905.SessionManager>(),
        ));
    gh.singleton<_i557.ApiClient>(
        () => _i557.ApiClient(gh<_i908.AuthService>()));
    gh.factory<_i481.AuthRepository>(() => _i481.AuthRepository(
          gh<_i905.SupabaseAuthDatasource>(),
          gh<_i905.SessionManager>(),
          gh<_i855.AuthService>(),
        ));
    gh.factory<_i561.AuthCubit>(
        () => _i561.AuthCubit(gh<_i388.AuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
