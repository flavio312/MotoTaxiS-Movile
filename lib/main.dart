import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajeseguro/core/network/http_client.dart';
import 'package:viajeseguro/core/network/api_config.dart';
import 'package:viajeseguro/features/conductor/domain/usecase/register_conductor.dart';
// -----------LOGIN
import 'package:viajeseguro/features/login/data/datasource/auth_local_datasource.dart';
import 'package:viajeseguro/features/login/data/datasource/auth_remote_datasource.dart';
import 'package:viajeseguro/features/login/data/repositories/auth_repository_impl.dart';
import 'package:viajeseguro/features/login/domain/usecase/get_current.dart';
import 'package:viajeseguro/features/login/domain/usecase/login_user.dart';
import 'package:viajeseguro/features/login/domain/usecase/logout_user.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';
// ----------- DATES OF THE PERSON
import 'package:viajeseguro/features/login/presentation/providers/person_provider.dart';
import 'package:viajeseguro/features/login/data/datasource/person_datasource.dart';
import 'package:viajeseguro/features/login/data/repositories/person_repository_impl.dart';
import 'package:viajeseguro/features/login/domain/usecase/register_person.dart';
// -----------DATES OF THE USERS
import 'package:viajeseguro/features/profile/domain/usecases/create_user.dart';
import 'package:viajeseguro/features/profile/presentation/providers/profile_provider.dart';
import 'package:viajeseguro/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:viajeseguro/features/profile/data/datasource/profile_datasource.dart';
// -----------ADDRES
import 'package:viajeseguro/features/addres/data/datasource/addres_datasource.dart';
import 'package:viajeseguro/features/addres/data/repositories/addres_repository_impl.dart';
import 'package:viajeseguro/features/addres/domain/usecases/register_addres.dart';
import 'package:viajeseguro/features/addres/presentation/providers/addres_providers.dart';
// -----------DATES OF THE CONDUCTOR
import 'package:viajeseguro/features/conductor/data/datasource/conductor_datasource.dart';
import 'package:viajeseguro/features/conductor/data/repositories/conductor_repository_impl.dart';
import 'package:viajeseguro/features/conductor/presentation/providers/conductor_provider.dart';
// -----------DATES OF THE PROPIETARIO
import 'package:viajeseguro/features/propietario/data/datasource/propietario_datasource.dart';
import 'package:viajeseguro/features/propietario/data/repository/propietario_repository_impl.dart';
import 'package:viajeseguro/features/propietario/domain/usecases/register_propietario.dart';
import 'package:viajeseguro/features/propietario/presentation/providers/propietario_provider.dart';
import 'package:viajeseguro/features/propietario/domain/usecases/register_vehiculo.dart';
import 'package:viajeseguro/features/propietario/presentation/providers/vehiculo_provider.dart';
import 'package:viajeseguro/features/propietario/domain/usecases/get_vehiculos.dart';
import 'package:viajeseguro/features/propietario/domain/usecases/change_vehiculo_status.dart';
import 'package:viajeseguro/features/propietario/domain/usecases/update_vehiculo.dart';
// ----------- DATES OF THE GET ME
import 'package:viajeseguro/features/settings/presentation/providers/settings_provider.dart';
import 'package:viajeseguro/features/settings/domain/usecases/get_me.dart';
import 'package:viajeseguro/features/settings/data/datasource/settings_datasource.dart';
import 'package:viajeseguro/features/settings/data/repository/settings_repository_impl.dart';
import 'myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final sharedPreferences = await SharedPreferences.getInstance();
  final httpClient = HttpClient(
    baseUrl: dotenv.env['API_BASE_URL']!,
  );

  // --- Auth setup ---
  final authRemoteDataSource = AuthRemoteDataSourceImpl(httpClient: httpClient);
  final authLocalDataSource = AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    localDataSource: authLocalDataSource,
  );
  final loginUser = AuthLogin(authRepository);
  final logoutUser = LogoutUser(authRepository);
  final getCurrentUser = GetCurrentUser(authRepository);
  // --- Person setup ---
  final personRepository = PersonRepositoryImpl(
    datasource: PersonDatasource(httpClient: ApiConfig.httpClient),
  );
  final registerPerson = RegisterPerson(personRepository);
  // --- Profile setup ---
  final profileRepository = ProfileRepositoryImpl(
    datasource: ProfileDatasource(httpClient: ApiConfig.httpClient),
  );
  final createUser = CreateUser(repository: profileRepository);

  // Address setup
  final addresRepository = AddresRepositoryImpl(
    datasource: AddresDatasource(httpClient: ApiConfig.httpClient),
  );
  final registerAddres = RegisterAddres(repository: addresRepository);

  // Conductor setup
  final conductorRepository = ConductorRepositoryImpl(
    datasource: ConductorDatasource(httpClient: ApiConfig.httpClient),
  );
  final registerConductor = RegisterConductor(conductorRepository);
  // Propietario setup
  final propietarioRepository = PropietarioRepositoryImpl(
    datasource: PropietarioDatasource(httpClient: ApiConfig.httpClient),
  );
  final registerPropietario = RegisterPropietario(propietarioRepository);
  final registerVehiculo = RegisterVehiculo(propietarioRepository);
  final getVehiculos = GetVehiculos(propietarioRepository);
  final updateVehiculo = UpdateVehiculo(propietarioRepository);
  final changeVehiculoStatus = ChangeVehiculoStatus(propietarioRepository);

  // Settings setup
 final settingsRepository = SettingsRepositoryImpl(
   datasource: SettingsDatasource(httpClient: ApiConfig.httpClient),
 );
 final getMe = GetMe(settingsRepository);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUseCase: loginUser,
            logoutUseCase: logoutUser,
            getCurrentUserUseCase: getCurrentUser,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PersonProvider(
            registerPersonUseCase: registerPerson,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(
            createUserUseCase: createUser,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddresProvider(
            registerAddresUseCase: registerAddres,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ConductorProvider(
              registerConductorUseCase: registerConductor,
          )
        ),
        ChangeNotifierProvider(
          create: (_) => PropietarioProvider(
            registerProietarioUseCase: registerPropietario,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => VehiculoProvider(
            registerVehiculo: registerVehiculo,
            getVehiculos: getVehiculos,
            updateVehiculo: updateVehiculo,
            changeVehiculoStatus: changeVehiculoStatus
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProfileProvider(
            getMe: getMe,
          ),
        ),
      ],
      child: const Myapp(),
    ),
  );
}
