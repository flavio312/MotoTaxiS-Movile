class ProfileModel {
  final String nombreUsuario;
  final String password;
  final String rol;
  final String? fotoPerfil;

  const ProfileModel({
    required this.nombreUsuario,
    required this.password,
    required this.rol,
    this.fotoPerfil,
  });

  Map<String, String> toFields() => {
    'nombreUsuario': nombreUsuario,
    'password': password,
    'rol': rol,
  };

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    nombreUsuario: json['nombreUsuario'] ?? '',
    password: json['password'] ?? '',
    rol: json['rol'] ?? '',
    fotoPerfil: json['fotoPerfil'],
  );
}