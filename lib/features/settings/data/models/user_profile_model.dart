import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.idUsuario,
    required super.nombreUsuario,
    required super.correoElectronico,
    required super.telefono,
    required super.rol,
    required super.estadoCuenta,
    required super.fechaRegistro,
    super.fotoPerfil,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      idUsuario: json['idUsuario'] ?? 0,
      nombreUsuario: json['nombreUsuario'] ?? '',
      correoElectronico: json['correoElectronico'] ?? '',
      telefono: json['telefono'] ?? '',
      rol: json['rol'] ?? '',
      estadoCuenta: json['estadoCuenta'] ?? '',
      fechaRegistro: json['fechaRegistro'] ?? '',
      fotoPerfil: json['fotoPerfil'],
    );
  }
}