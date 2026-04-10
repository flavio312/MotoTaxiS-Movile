import 'package:equatable/equatable.dart';

class Addres extends Equatable{
  final int idDireccion;
  final String estado;
  final String municipio;
  final String asentamiento;
  final String codigoPostal;
  final String calle;
  final String numeroExterior;
  final String numeroInterior;
  final String latitud;
  final String longitud;

  const Addres({
    required this.idDireccion,
    required this.estado,
    required this.municipio,
    required this.asentamiento,
    required this.codigoPostal,
    required this.calle,
    required this.numeroExterior,
    required this.numeroInterior,
    required this.latitud,
    required this.longitud,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    idDireccion,
    estado,
    municipio,
    asentamiento,
    codigoPostal,
    calle,
    numeroExterior,
    numeroInterior,
    latitud,
    longitud,
  ];
}