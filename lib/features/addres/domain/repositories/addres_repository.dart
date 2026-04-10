abstract class AddresRepository{
  Future<void> registerAddres({
    required Map<String, dynamic> data,
    required String token,
});
}