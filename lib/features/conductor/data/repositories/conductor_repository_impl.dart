import '../models/conductor_model.dart';
import '../../domain/repositories/conductor_repository.dart';
import '../datasource/conductor_datasource.dart';
import '../../domain/entities/conductor.dart';


class ConductorRepositoryImpl implements ConductorRepository{
  final ConductorDatasource datasource;

  ConductorRepositoryImpl({required this.datasource});

  @override
  Future<void> registerConductor({
    required Conductor conductor,
    required String token
  }) {
    // TODO: implement registerConductor
    final model = ConductorModel.fromEntity(conductor);
    return datasource.registerConductor(
        data: model.toJson(),
        token: token,
    );
  }
}