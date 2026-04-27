import '../entities/ubicacion.dart';
import '../repositories/servicio_repository.dart';

class EscucharUbicacionUsecase {
  final ServicioRepository repository;
  EscucharUbicacionUsecase(this.repository);

  Stream<UbicacionEntity> call() =>
      repository.escucharUbicacionConductor();
}