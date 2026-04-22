import '../repository/propietario_repository.dart';

class ChangeVehiculoStatus {
  final PropietarioRepository repository;

  ChangeVehiculoStatus(this.repository);

  Future<void> call({
    required int idVehiculo,
    required String token,
  }) {
    return repository.changeVehiculoStatus(
      idVehiculo: idVehiculo,
      token: token,
    );
  }
}