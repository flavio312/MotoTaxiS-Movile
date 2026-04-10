import 'package:viajeseguro/features/addres/data/datasource/addres_datasource.dart';

import '../../domain/repositories/addres_repository.dart';

class AddresRepositoryImpl implements AddresRepository {
  final AddresDatasource datasource;

  AddresRepositoryImpl({required this.datasource});

  @override
  Future<void> registerAddres({
    required Map<String, dynamic> data,
    required String token
    // TODO: implement registerAddres
  }){
  return datasource.registerAddres(data: data, token: token);

  }
}