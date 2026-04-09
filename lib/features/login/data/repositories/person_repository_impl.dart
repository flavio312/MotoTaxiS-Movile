import '../../domain/repositories/person_repository.dart';
import '../datasource/person_datasource.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonDatasource datasource;

  PersonRepositoryImpl({required this.datasource});

  @override
  Future<void> registerPerson({
    required Map<String, dynamic> data,
    required String token,
  }) {
    return datasource.registerPerson(data: data, token: token);
  }
}