import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:viajeseguro/core/network/http_client.dart';
import 'package:viajeseguro/features/login/data/datasource/auth_local_datasource.dart';
import 'package:viajeseguro/features/login/data/datasource/auth_remote_datasource.dart';
import 'package:viajeseguro/features/login/data/repositories/auth_repository_impl.dart';
import 'package:viajeseguro/features/login/domain/usecase/get_current.dart';
import 'package:viajeseguro/features/login/domain/usecase/login_user.dart';
import 'package:viajeseguro/features/login/domain/usecase/logout_user.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';

import 'myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final sharedPreferences = await SharedPreferences.getInstance();

  final httpClient = HttpClient(
    baseUrl: dotenv.env['API_BASE_URL']!,
  );

  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    httpClient: httpClient,
  );

  final authLocalDataSource = AuthLocalDataSourceImpl(
    sharedPreferences: sharedPreferences,
  );

  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    localDataSource: authLocalDataSource,
  );

  final loginUser = AuthLogin(authRepository);
  final logoutUser = LogoutUser(authRepository);
  final getCurrentUser = GetCurrentUser(authRepository);

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
      ],
      child: const Myapp(),
    ),
  );
}
