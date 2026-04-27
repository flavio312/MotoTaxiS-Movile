import '../entities/ubicacion.dart';
import '../repositories/servicio_repository.dart';

class EmitirTrackingUsecase {
  final ServicioRepository repository;
  EmitirTrackingUsecase(this.repository);

  void call(int idServicio, UbicacionEntity ubicacion) =>
      repository.emitirTracking(idServicio, ubicacion);
}