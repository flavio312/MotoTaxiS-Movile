import 'package:equatable/equatable.dart';

class Conductor extends Equatable{
  final int idConductor;
  final String licencia;
  final String licenciaFechaExpedicion;
  final String licenciaFechaVencimiento;
  final String estatus;
  final String descripcion;
  final String fechaRegistro;
  final String fechaInicio;
  final String fechaFin;
  final String dias;
  final String horas;

  const Conductor ({
    required this.idConductor,
    required this.licencia,
    required this.licenciaFechaExpedicion,
    required this.licenciaFechaVencimiento,
    required this.estatus,
    required this.descripcion,
    required this.fechaRegistro,
    required this.fechaInicio,
    required this.fechaFin,
    required this.dias,
    required this.horas,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    idConductor,
    licencia,
    licenciaFechaExpedicion,
    licenciaFechaVencimiento,
    estatus,
    descripcion,
    fechaRegistro,
    fechaInicio,
    fechaFin,
    dias,
    horas,
  ];
}