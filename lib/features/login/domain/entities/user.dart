import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int idUsuario;
  final String nombreUsuario;
  final String password;
  final String rol;
  final String estadoCuenta;
  final String fechaRegistro;
  final String? fotoPerfil;

  const User({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.password,
    required this.rol,
    required this.estadoCuenta,
    required this.fechaRegistro,
    required this.fotoPerfil
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    idUsuario,
    nombreUsuario,
    password,
    rol,
    estadoCuenta,
    fechaRegistro,
    fotoPerfil
  ];
}

