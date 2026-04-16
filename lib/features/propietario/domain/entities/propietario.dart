import 'package:equatable/equatable.dart';

class Propietario extends Equatable{
  final int idPropietario;
  final String rfc;
  final String razonSocial;

  const Propietario({
    required this.idPropietario,
    required this.rfc,
    required this.razonSocial
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    idPropietario,
    rfc,
    razonSocial
  ];
}