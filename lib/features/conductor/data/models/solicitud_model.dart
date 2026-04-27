import '../../domain/entities/solicitud.dart';

class SolicitudModel {
  final int    idServicio;
  final String conductor;
  final String tipoPaquete;
  final String origen;
  final String destino;
  final int    idConductor;
  final String latOrigen;
  final String lngOrigen;
  final String latDestino;
  final String lngDestino;
  final String estado;

  const SolicitudModel({
    required this.idServicio,
    required this.conductor,
    required this.tipoPaquete,
    required this.origen,
    required this.destino,
    required this.idConductor,
    required this.latOrigen,
    required this.lngOrigen,
    required this.latDestino,
    required this.lngDestino,
    this.estado = 'solicitado',
  });

  factory SolicitudModel.fromJson(Map<String, dynamic> json) {
    return SolicitudModel(
      idServicio:  (json['idServicio']  as num).toInt(),
      idConductor: (json['idConductor'] as num?)?.toInt() ?? 0,
      conductor:   json['nombreUsuario'] as String?
          ?? json['conductor']  as String?
          ?? '',
      tipoPaquete: json['tipoServicio'] ?? '',
      origen:      json['origen']     ?? '',
      destino:     json['destino']    ?? '',
      latOrigen:   json['latOrigen']   ?? '',
      lngOrigen:   json['lngOrigen']   ?? '',
      latDestino:  json['latDestino']  ?? '',
      lngDestino:  json['lngDestino']  ?? '',
      estado:      json['estado']      as String? ?? 'solicitado',
    );
  }

  Map<String, dynamic> toJson() => {
    'idServicio':  idServicio,
    'idConductor': idConductor,
    'conductor':   conductor,
    'tipoPaquete': tipoPaquete,
    'origen':      origen,
    'destino':     destino,
    'latOrigen':   latOrigen,
    'lngOrigen':   lngOrigen,
    'latDestino':  latDestino,
    'lngDestino':  lngDestino,
    'estado':      estado,
  };

  factory SolicitudModel.fromEntity(SolicitudEntity entity) => SolicitudModel(
    idServicio:  entity.idServicio,
    idConductor: entity.idConductor,
    conductor:   entity.conductor,
    tipoPaquete: entity.tipoPaquete,
    origen:      entity.origen,
    destino:     entity.destino,
    latOrigen:   entity.latOrigen,
    lngOrigen:   entity.lngOrigen,
    latDestino:  entity.latDestino,
    lngDestino:  entity.lngDestino,
    estado:      entity.estado,
  );

  SolicitudEntity toEntity() => SolicitudEntity(
    idServicio:  idServicio,
    idConductor: idConductor,
    conductor:   conductor,
    tipoPaquete: tipoPaquete,
    origen:      origen,
    destino:     destino,
    latOrigen:   latOrigen,
    lngOrigen:   lngOrigen,
    latDestino:  latDestino,
    lngDestino:  lngDestino,
    estado:      estado,
  );
}