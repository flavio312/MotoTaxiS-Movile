import 'package:flutter/cupertino.dart';

import '../../domain/repositories/conductor_repository.dart';
import '../datasource/conductor_datasource.dart';

class ConductorRepositoryImpl implements ConductorRepository{
  final ConductorDatasource datasource;

  ConductorRepositoryImpl({required this.datasource});

  @override
  Future<void> registerConductor({
    required Map<String, dynamic> data,
    required String token}) {
    // TODO: implement registerConductor
  return datasource.registerConductor(data: data, token: token);
  }
}