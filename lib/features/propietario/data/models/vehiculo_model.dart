import '../../domain/entities/vehiculo.dart';

class VehiculoModel extends Vehiculo{
  const VehiculoModel({
    required super.idVehiculo,
    required super.inmatriculacion,
    required super.idModelo,
    required super.color,
    required super.fechaAdquisicion,
    required super.estatus,
    required super.descripcion,
  });

  factory VehiculoModel.fromJson(Map<String, dynamic> json) {
    return VehiculoModel(
      idVehiculo: json['idVehiculo'] ?? 0,
      inmatriculacion: json['matricula'] ?? '',
      idModelo: (json['modelo'] ?? 0) as int,
      color: json['color'] ?? '',
      fechaAdquisicion: json['fechaAdquisicion'] ?? '',
      estatus: json['estatus'] ?? '',
      descripcion: json['descripcion'] ?? '',
    );
  }

  factory VehiculoModel.fromEntity(Vehiculo vehiculo){
    return VehiculoModel(
      idVehiculo: vehiculo.idVehiculo,
        inmatriculacion: vehiculo.inmatriculacion,
        idModelo: vehiculo.idModelo,
        color: vehiculo.color,
        fechaAdquisicion: vehiculo.fechaAdquisicion,
        estatus: vehiculo.estatus,
        descripcion: vehiculo.descripcion,
    );
  }
}