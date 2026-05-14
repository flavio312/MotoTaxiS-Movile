import '../../domain/entities/solicitud.dart';

class SolicitudModel extends Solicitud{
  SolicitudModel({
    required super.idServicio,
    required super.idConductor,
    required super.tipoPaquete,
    required super.origen,
    required super.destino,
    required super.latOrigen,
    required super.lngOrigen,
    required super.latDestino,
    required super.lngDestino,
    super.estado = 'solicitado',
  });

  factory SolicitudModel.fromJson(Map<String, dynamic> json) {
    return SolicitudModel(
      idServicio:  json['idServicio']  ?? 0,
      idConductor: json['idConductor']  ?? 0,
      tipoPaquete: json['tipoServicio'] ?? '',
      origen:      json['origen']     ?? '',
      destino:     json['destino']    ?? '',
      latOrigen:   json['latOrigen']   ?? '',
      lngOrigen:   json['lngOrigen']   ?? '',
      latDestino:  json['latDestino']  ?? '',
      lngDestino:  json['lngDestino']  ?? '',
      estado:      json['estado'] ?? 'solicitado',
    );
  }

  factory SolicitudModel.fromEntity(Solicitud solicitud){
    return SolicitudModel(
        idServicio: solicitud.idServicio,
        tipoPaquete: solicitud.tipoPaquete,
        origen: solicitud.origen,
        destino: solicitud.destino,
        idConductor: solicitud.idConductor,
        latOrigen: solicitud.latOrigen,
        lngOrigen: solicitud.lngOrigen,
        latDestino: solicitud.latDestino,
        lngDestino: solicitud.lngDestino
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "idServicio": idServicio,
      "idConductor": idConductor,
      "tipoPaquete": tipoPaquete,
      "origen": origen,
      "destino": destino,
      "latOrigen": latOrigen,
      "lngOrigen": lngOrigen,
      "latDestino": latDestino,
      "lngDestino": lngDestino,
      "estado": estado,
    };
  }
}