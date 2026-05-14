import 'package:viajeseguro/features/conductor/domain/entities/qr_conductor.dart';

class QrConductorModel {
  final String qrCode;

  QrConductorModel({required this.qrCode});

  factory QrConductorModel.fromJson(Map<String, dynamic> json) {
    return QrConductorModel(
      qrCode: json['qrCode'],
    );
  }

  QrConductorEntity toEntity() {
    return QrConductorEntity(
      qrCode: qrCode,
      nombre: '',
      licencia: '',
      telefono: '',
      fotoPerfil: '',
    );
  }
}
