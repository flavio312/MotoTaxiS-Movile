import '../entities/conductor.dart';
import '../entities/qr_conductor.dart';

abstract class ConductorRepository{
  Future<void> registerConductor({
    required Conductor conductor,
    required String token,
  });

  Future<QrConductorEntity> getQrConductor(String token);
}