import '../entities/ubicacion.dart';

abstract class ServicioRepository {
  void registrarConductor(int idConductor);
  void aceptarServicio(int idServicio, int idConductor);
  void emitirTracking(int idServicio, UbicacionEntity ubicacion);
  void unirseServicio(int idServicio);
  Stream<UbicacionEntity> escucharUbicacionConductor();
  Stream<int> escucharServicioTomado();
}