class SolicitudEntity {
  final int    idServicio;
  final int    idConductor;
  final String conductor;
  final String tipoPaquete;
  final String origen;
  final String destino;
  final String latOrigen;
  final String lngOrigen;
  final String latDestino;
  final String lngDestino;
  final String estado;

  const SolicitudEntity({
    required this.idServicio,
    required this.idConductor,
    required this.conductor,
    required this.tipoPaquete,
    required this.origen,
    required this.destino,
    required this.latOrigen,
    required this.lngOrigen,
    required this.latDestino,
    required this.lngDestino,
    this.estado = 'solicitado',
  });
}