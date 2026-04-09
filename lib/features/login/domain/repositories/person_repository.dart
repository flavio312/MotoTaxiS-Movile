
abstract class PersonRepository {
  Future<void> registerPerson({
    required Map<String, dynamic> data,
    required String token,
  });
}