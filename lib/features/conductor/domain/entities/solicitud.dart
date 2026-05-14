import 'package:equatable/equatable.dart';

class Solicitud extends Equatable {
  final int    idServicio;
  final int    idConductor;
  final String tipoPaquete;
  final String origen;
  final String destino;
  final String latOrigen;
  final String lngOrigen;
  final String latDestino;
  final String lngDestino;
  final String estado;

  const Solicitud({
    required this.idServicio,
    required this.idConductor,
    required this.tipoPaquete,
    required this.origen,
    required this.destino,
    required this.latOrigen,
    required this.lngOrigen,
    required this.latDestino,
    required this.lngDestino,
    this.estado = 'solicitado',
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    idServicio,
    idConductor,
    tipoPaquete,
    origen,
    destino,
    latOrigen,
    lngDestino,
    latOrigen,
    lngDestino,
    estado,
  ];
}