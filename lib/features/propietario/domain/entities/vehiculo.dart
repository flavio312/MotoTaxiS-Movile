import 'package:equatable/equatable.dart';

class Vehiculo extends Equatable {
  final int idVehiculo;
  final String inmatriculacion;
  final int idModelo;
  final String color;
  final String fechaAdquisicion;
  final String estatus;
  final String descripcion;

  const Vehiculo({
    required this.idVehiculo,
    required this.inmatriculacion,
    required this.idModelo,
    required this.color,
    required this.fechaAdquisicion,
    required this.estatus,
    required this.descripcion,
  });

  @override
  List<Object?> get props => [
    idVehiculo,
    inmatriculacion,
    idModelo,
    color,
    fechaAdquisicion,
    estatus,
    descripcion
  ];
}