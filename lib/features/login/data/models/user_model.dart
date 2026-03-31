import '../../domain/entities/auth.dart';

class UserModel extends Auth{
  const UserModel({
    required super.idUsuario,
    required super.nombreUsuario,
    required super.password,
    required super.rol,
    required super.estadoCuenta,
    required super.fechaRegistro,
    required super.fotoPerfil
  });

  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
        idUsuario: json["idUsuario"] is int ? json['idUsuario'] : int.tryParse(json['idUsuario'].toString()) ?? 0,
        nombreUsuario: json['nombreUsuario'] ?? '',
        password: json['password'] ?? '',
        rol: json['rol'] ?? '',
        estadoCuenta: json['estadoCuenta'] ?? '',
        fechaRegistro: json['fechaRegistro'] ?? '',
        fotoPerfil: json['fotoPerfil'] ?? ''
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'idUsuario':idUsuario,
      'nombreUsuario':nombreUsuario,
      'rol':rol,
      'estadoCuenta':estadoCuenta,
      'fechaRegistro':fechaRegistro
    };
  }

  factory UserModel.fromEntity(Auth auth){
    return UserModel(
        idUsuario: auth.idUsuario,
        nombreUsuario: auth.nombreUsuario,
        password: auth.password,
        rol: auth.rol,
        estadoCuenta: auth.estadoCuenta,
        fechaRegistro: auth.fechaRegistro,
        fotoPerfil: auth.fotoPerfil
    );
  }
}