import '../../domain/entities/propietario.dart';

class PropietarioModel extends Propietario{
  const PropietarioModel({
    required super.idPropietario,
    required super.rfc,
    required super.razonSocial
  });

  factory PropietarioModel.fromJson(Map<String, dynamic> json){
    return PropietarioModel(
    idPropietario: json['idPropietario'] ?? 0,
    rfc: json['rfc'] ?? '',
    razonSocial: json['razonSocial'] ?? ''
    );
  }
  factory PropietarioModel.fromEntity(Propietario propietario){
    return PropietarioModel(
    idPropietario: propietario.idPropietario,
    rfc: propietario.rfc,
    razonSocial: propietario.razonSocial
    );
  }
}