import '../../domain/entities/ubicacion.dart';
import '../../domain/repositories/servicio_repository.dart';
import '../datasource/socket_datasource.dart';

class ServicioRepositoryImpl implements ServicioRepository {
  final SocketDatasource datasource;

  ServicioRepositoryImpl({required this.datasource});

  @override
  void registrarConductor(int idConductor) =>
      datasource.registrarConductor(idConductor);

  @override
  void unirseServicio(int idServicio) =>
      datasource.unirseServicio(idServicio);

  @override
  void aceptarServicio(int idServicio, int idConductor) =>
      datasource.aceptarServicio(idServicio, idConductor);

  @override
  void emitirTracking(int idServicio, UbicacionEntity ubicacion) =>
      datasource.emitirTracking(
        idServicio,
        ubicacion.latitud,
        ubicacion.longitud,
        ubicacion.velocidad,
      );

  @override
  Stream<UbicacionEntity> escucharUbicacionConductor() =>
      datasource.escucharUbicacionConductor().map((data) => UbicacionEntity(
        latitud: (data['latitud'] as num).toDouble(),
        longitud: (data['longitud'] as num).toDouble(),
        velocidad: (data['velocidad'] as num).toDouble(),
      ));

  @override
  Stream<int> escucharServicioTomado() =>
      datasource.escucharServicioTomado();
}