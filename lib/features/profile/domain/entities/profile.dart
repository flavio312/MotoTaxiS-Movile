class Profile{
  final String nombreUsuario;
  final String password;
  final String rol;
  final String? fotoPerfil;

  const Profile({
    required this.nombreUsuario,
    required this.password,
    required this.rol,
    this.fotoPerfil,
  });
}