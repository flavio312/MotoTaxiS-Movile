import '../../domain/entities/user.dart';

class UserModel extends User{
  const UserModel({
    required super.idUsuario,
    required super.nombreUsuario,
    required super.password,
    required super.rol,
    required super.estadoCuenta,
    required super.fechaRegistro,
    super.fotoPerfil
  });

  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
        idUsuario: json["idUsuario"] is int ? json['idUsuario'] : int.tryParse(json['id'].toString()) ?? 0,
        nombreUsuario: json['nombreUsuario'] ?? json['nombreUsuario'] ?? '',
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
      'password':password,
      'rol':rol,
      'estadoCuenta':estadoCuenta,
      'fechaRegistro':fechaRegistro
    };
  }

  factory UserModel.fromEntity(User user){
    return UserModel(
        idUsuario: user.idUsuario,
        nombreUsuario: user.nombreUsuario,
        password: user.password,
        rol: user.rol,
        estadoCuenta: user.estadoCuenta,
        fechaRegistro: user.fechaRegistro,
        fotoPerfil: user.fotoPerfil
    );
  }
}