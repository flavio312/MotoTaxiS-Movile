import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketDatasource {
  void registrarConductor(int idConductor);
  void aceptarServicio(int idServicio, int idConductor);
  void emitirTracking(int idServicio, double lat, double lng, double velocidad);
  void emitirUbicacion(int idConductor, double lat, double lng);
  void unirseServicio(int idServicio);
  Stream<Map<String, dynamic>> escucharUbicacionConductor();
  Stream<int> escucharServicioTomado();
  void dispose();
}

class SocketDatasourceImpl implements SocketDatasource {
  final IO.Socket socket;

  SocketDatasourceImpl({required this.socket});

  @override
  void registrarConductor(int idConductor) {
    socket.emit('registrarConductor', idConductor);
  }
  @override
  void unirseServicio(int idServicio) {
    socket.emit('unirseServicio', idServicio);
  }

  @override
  void aceptarServicio(int idServicio, int idConductor) {
    socket.emit('aceptarServicio', {
      'idServicio': idServicio,
      'idConductor': idConductor,
    });
  }

  @override
  void emitirTracking(int idServicio, double lat, double lng, double velocidad) {
    socket.emit('tracking', {
      'idServicio': idServicio,
      'latitud': lat,
      'longitud': lng,
      'velocidad': velocidad,
    });
  }

  @override
  void emitirUbicacion(int idConductor, double lat, double lng) {
    socket.emit('ubicacion', {
      'idConductor': idConductor,
      'latitud': lat,
      'longitud': lng,
    });
  }

  @override
  Stream<Map<String, dynamic>> escucharUbicacionConductor() {
    return Stream.multi((controller) {
      socket.on('ubicacionConductor', (data) {
        controller.add(Map<String, dynamic>.from(data));
      });
    });
  }

  @override
  Stream<int> escucharServicioTomado() {
    return Stream.multi((controller) {
      socket.on('servicioTomado', (idServicio) {
        controller.add(idServicio as int);
      });
    });
  }

  @override
  void dispose() {
    socket.off('ubicacionConductor');
    socket.off('servicioTomado');
  }
}