abstract class ConductorRepository{
  Future<void> registerConductor({
    required Map<String, dynamic> data,
    required String token,
  });
}