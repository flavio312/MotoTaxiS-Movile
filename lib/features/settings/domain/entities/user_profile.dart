import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final int idUsuario;
  final String nombreUsuario;
  final String correoElectronico;
  final String telefono;
  final String rol;
  final String estadoCuenta;
  final String fechaRegistro;
  final String? fotoPerfil;

  const UserProfile({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.correoElectronico,
    required this.telefono,
    required this.rol,
    required this.estadoCuenta,
    required this.fechaRegistro,
    this.fotoPerfil,
  });

  @override
  List<Object?> get props => [
    idUsuario, nombreUsuario, correoElectronico, telefono,
    rol, estadoCuenta, fechaRegistro, fotoPerfil,
  ];
}