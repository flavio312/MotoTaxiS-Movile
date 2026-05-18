import 'package:viajeseguro/features/conductor/data/models/qr_conductor_model.dart';
import 'package:viajeseguro/features/conductor/domain/entities/qr_conductor.dart';
import 'package:viajeseguro/features/conductor/domain/repositories/conductor_repository.dart';
import 'package:viajeseguro/features/conductor/data/models/conductor_model.dart';
import 'package:viajeseguro/features/conductor/data/datasource/conductor_datasource.dart';
import 'package:viajeseguro/features/conductor/domain/entities/conductor.dart';

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

  @override
  Future<QrConductorEntity> getQrConductor(String token) async {
    final result = await datasource.getQrConductor(token);

    final model = QrConductorModel.fromJson(result);

    return model.toEntity();
  }
}