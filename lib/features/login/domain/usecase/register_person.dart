import '../repositories/person_repository.dart';

class RegisterPerson {
  final PersonRepository repository;

  RegisterPerson(this.repository);

  Future<void> call({
    required Map<String, dynamic> data,
    required String token,
  }) {
    return repository.registerPerson(data: data, token: token);
  }
}