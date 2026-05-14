import 'package:equatable/equatable.dart';

class QrConductorEntity extends Equatable {
  final String qrCode;
  final String nombre;
  final String licencia;
  final String telefono;
  final String fotoPerfil;

  const QrConductorEntity({
    required this.qrCode,
    required this.nombre,
    required this.licencia,
    required this.telefono,
    required this.fotoPerfil,
  });

  @override
  List<Object?> get props => [
    qrCode,
    nombre,
    licencia,
    telefono,
    fotoPerfil,
  ];
}
