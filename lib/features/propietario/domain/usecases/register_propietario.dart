import '../repository/propietario_repository.dart';

class RegisterPropietario{
  final PropietarioRepository repository;

  RegisterPropietario(this.repository);

  Future<void> call({
    required Map<String, dynamic> data,
    required String token,
  }){
    return repository.registerPropietario(data: data, token: token);
  }
}