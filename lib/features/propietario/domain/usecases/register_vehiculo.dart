import '../repository/propietario_repository.dart';

class RegisterVehiculo{
  final PropietarioRepository repository;

  RegisterVehiculo(this.repository);

  Future<void> call({
    required Map<String, dynamic> data,
    required String token,
  }){
    return repository.registerVehiculo(data: data, token: token);
  }
}