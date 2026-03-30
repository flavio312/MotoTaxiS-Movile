class LoginRequestModel {
  final String nombreUsuario;
  final String password;

  LoginRequestModel({
    required this.nombreUsuario,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    return {
      'nombreUsuario': nombreUsuario,
      'password': password
    };
  }
}