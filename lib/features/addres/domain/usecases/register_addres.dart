import '../repositories/addres_repository.dart';

class RegisterAddres{
  final AddresRepository repository;

  RegisterAddres(this.repository);

  Future<void> call ({
    required Map<String, dynamic> data,
    required String token,
  }){
    return repository.registerAddres(data: data, token: token);
  }
}