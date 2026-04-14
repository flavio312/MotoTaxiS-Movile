import '../repositories/conductor_repository.dart';

class RegisterConductor{
  final ConductorRepository repository;

  RegisterConductor(this.repository);

  Future<void> call({
    required Map<String, dynamic> data,
    required String token,
  }){
    return repository.registerConductor(data: data, token: token);
  }
}