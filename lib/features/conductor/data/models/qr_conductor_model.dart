import 'package:viajeseguro/features/conductor/domain/entities/qr_conductor.dart';

class QrConductorModel {
  final String qrCode;
  final String nombre;
  final String licencia;
  final String telefono;
  final String fotoPerfil;

  QrConductorModel({
    required this.qrCode,
    required this.nombre,
    required this.licencia,
    required this.telefono,
    required this.fotoPerfil,
  });

  factory QrConductorModel.fromJson(Map<String, dynamic> json) {
    return QrConductorModel(
      qrCode: json['qrCode'] ?? '',
      nombre: json['nombre'] ?? '',
      licencia: json['licencia'] ?? '',
      telefono: json['telefono'] ?? '',
      fotoPerfil: json['fotoPerfil'] ?? '',
    );
  }

  QrConductorEntity toEntity() {
    return QrConductorEntity(
      qrCode: qrCode,
      nombre: nombre,
      licencia: licencia,
      telefono: telefono,
      fotoPerfil: fotoPerfil,
    );
  }
}