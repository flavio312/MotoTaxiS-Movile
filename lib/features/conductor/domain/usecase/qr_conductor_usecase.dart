import '../repositories/conductor_repository.dart';
import '../entities/qr_conductor.dart';

class GetQrConductorUseCase {
  final ConductorRepository repository;

  GetQrConductorUseCase(this.repository);

  Future<QrConductorEntity> call(String token) {
    return repository.getQrConductor(token);
  }
}
