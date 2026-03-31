import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/person.dart';
import '../repositories/auth.dart';

class RegisterPerson implements UseCase<Person, RegisterPersonParams> {
  final AuthRepository repository;

  RegisterPerson(this.repository);

  @override
  Future<Either<Failure, Person>> call(RegisterPersonParams params) async {
    return await repository.createPerson(
      params.nombre,
      params.apellidoP,
      params.apellidoM,
      params.idSexo,
      params.correoElectronico,
      params.telefono,
      params.fechaNacimiento
    );
  }

}
class RegisterPersonParams{
  final int idPersona;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String idSexo;
  final String correoElectronico;
  final String telefono;
  final String fechaNacimiento;

  RegisterPersonParams({
    required this.idPersona,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.idSexo,
    required this.correoElectronico,
    required this.telefono,
    required this.fechaNacimiento
  });
}
