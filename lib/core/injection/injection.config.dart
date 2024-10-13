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
import '../../data/datasources/local/session_manager_datasource.dart' as _i207;
import '../../data/datasources/local/user_local_datasource.dart' as _i533;
import '../../data/datasources/remote/employee_datasource.dart' as _i319;
import '../../data/datasources/remote/employee_roll_call_datasource.dart'
    as _i316;
import '../../data/datasources/remote/leave_datasource.dart' as _i917;
import '../../data/datasources/remote/reimbursement_datasource.dart' as _i529;
import '../../data/datasources/remote/supabase_storage_datasource.dart'
    as _i330;
import '../../data/datasources/remote/supbase__auth_datasource.dart' as _i642;
import '../../data/repositories/auth_repository.dart' as _i481;
import '../../data/repositories/emmployee_storage_repository.dart' as _i683;
import '../../data/repositories/employee_repository.dart' as _i451;
import '../../data/repositories/employee_roll_call_repository.dart' as _i565;
import '../../data/repositories/leave_repository.dart' as _i672;
import '../../data/repositories/reimbursement_repository.dart' as _i555;
import '../../views/cubits/avatar_cubit.dart' as _i89;
import '../../views/cubits/employee_cubit.dart' as _i225;
import '../../views/cubits/employee_roll_call_cubit.dart' as _i103;
import '../../views/cubits/home_cubit.dart' as _i934;
import '../../views/cubits/leave_cubit.dart' as _i47;
import '../../views/cubits/login_cubit.dart' as _i35;
import '../../views/cubits/reimbursement_cubit.dart' as _i363;
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
    gh.factory<_i934.HomeCubit>(() => _i934.HomeCubit());
    gh.singleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.singleton<_i207.SessionManager>(() => _i207.SessionManager());
    gh.singleton<_i533.UserLocalDatasource>(() => _i533.UserLocalDatasource());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i330.SupabaseStorageDatasource>(
        () => _i330.SupabaseStorageDatasource(gh<_i454.SupabaseClient>()));
    gh.factory<_i642.SupabaseAuthDatasource>(
        () => _i642.SupabaseAuthDatasource(gh<_i454.SupabaseClient>()));
    gh.factory<_i683.EmployeeStorageRepository>(() =>
        _i683.EmployeeStorageRepository(gh<_i388.SupabaseStorageDatasource>()));
    gh.singleton<_i908.AuthService>(() => _i908.AuthService(
          gh<_i454.SupabaseClient>(),
          gh<_i905.SessionManager>(),
        ));
    gh.factory<_i481.AuthRepository>(() => _i481.AuthRepository(
          gh<_i905.SupabaseAuthDatasource>(),
          gh<_i905.SessionManager>(),
          gh<_i855.AuthService>(),
          gh<_i905.UserLocalDatasource>(),
        ));
    gh.factory<_i89.EmployeeAvatarCubit>(
        () => _i89.EmployeeAvatarCubit(gh<_i388.EmployeeStorageRepository>()));
    gh.singleton<_i557.ApiClient>(
        () => _i557.ApiClient(gh<_i908.AuthService>()));
    gh.factory<_i35.AuthCubit>(
        () => _i35.AuthCubit(gh<_i388.AuthRepository>()));
    gh.factory<_i319.EmployeeDataSource>(
        () => _i319.EmployeeDataSource(gh<_i557.ApiClient>()));
    gh.factory<_i316.EmployeeRollCallDataSource>(
        () => _i316.EmployeeRollCallDataSource(gh<_i557.ApiClient>()));
    gh.factory<_i917.LeaveRequestDataSource>(
        () => _i917.LeaveRequestDataSource(gh<_i557.ApiClient>()));
    gh.factory<_i529.ReimbursementRequestDataSource>(
        () => _i529.ReimbursementRequestDataSource(gh<_i557.ApiClient>()));
    gh.factory<_i555.ReimbursementRequestRepository>(() =>
        _i555.ReimbursementRequestRepository(
            gh<_i388.ReimbursementRequestDataSource>()));
    gh.factory<_i672.LeaveRequestRepository>(
        () => _i672.LeaveRequestRepository(gh<_i388.LeaveRequestDataSource>()));
    gh.factory<_i451.EmployeeRepository>(() => _i451.EmployeeRepository(
          gh<_i388.EmployeeDataSource>(),
          gh<_i388.UserLocalDatasource>(),
        ));
    gh.factory<_i565.EmployeeRollCallRepository>(() =>
        _i565.EmployeeRollCallRepository(
            gh<_i388.EmployeeRollCallDataSource>()));
    gh.factory<_i225.EmployeeCubit>(
        () => _i225.EmployeeCubit(gh<_i388.EmployeeRepository>()));
    gh.factory<_i363.ReimbursementRequestCubit>(() =>
        _i363.ReimbursementRequestCubit(
            gh<_i388.ReimbursementRequestRepository>()));
    gh.factory<_i103.EmployeeRollCallCubit>(() =>
        _i103.EmployeeRollCallCubit(gh<_i388.EmployeeRollCallRepository>()));
    gh.factory<_i47.LeaveRequestCubit>(
        () => _i47.LeaveRequestCubit(gh<_i388.LeaveRequestRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
