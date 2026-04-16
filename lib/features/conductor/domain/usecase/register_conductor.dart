import 'package:viajeseguro/features/conductor/domain/entities/conductor.dart';
import 'package:viajeseguro/features/conductor/domain/repositories/conductor_repository.dart';

class RegisterConductor{
  final ConductorRepository repository;

  RegisterConductor(this.repository);

  Future<void> call({
    required Conductor conductor,
    required String token,
  }){
    return repository.registerConductor(
        conductor: conductor,
        token: token
    );
  }
}