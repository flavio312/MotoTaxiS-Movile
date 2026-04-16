
abstract class PropietarioRepository{
  Future<void> registerPropietario({
    required Map<String, dynamic> data,
    required String token,
  });
}