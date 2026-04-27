import '../repositories/servicio_repository.dart';

class AceptarServicioUsecase {
  final ServicioRepository repository;
  AceptarServicioUsecase(this.repository);

  void call(int idServicio, int idConductor) =>
      repository.aceptarServicio(idServicio, idConductor);
}