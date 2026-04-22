import '../repository/propietario_repository.dart';

class UpdateVehiculo {
  final PropietarioRepository repository;

  UpdateVehiculo(this.repository);

  Future<void> call({
    required int idVehiculo,
    required Map<String, dynamic> data,
    required String token,
  }) {
    return repository.updateVehiculo(
      idVehiculo: idVehiculo,
      data: data,
      token: token,
    );
  }
}