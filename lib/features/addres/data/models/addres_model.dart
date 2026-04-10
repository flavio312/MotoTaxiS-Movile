import '../../domain/entities/addres.dart';

class AddresModel extends Addres{
  const AddresModel({
    required super.idDireccion,
    required super.estado,
    required super.municipio,
    required super.asentamiento,
    required super.codigoPostal,
    required super.calle,
    required super.numeroExterior,
    required super.numeroInterior,
    required super.latitud,
    required super.longitud,

  });

  factory AddresModel.fromJson(Map<String, dynamic> json){
    return AddresModel(
      idDireccion: json['idDireccion'] is int
        ? json['idDireccion']
        : int.tryParse(json['idDireccion'].toString()) ?? 0,
      estado: json['estado'] ?? '',
      municipio: json['municipio'] ?? '',
      asentamiento: json['asentamiento'] ?? '',
      codigoPostal: json['codigoPostal'] ?? '',
      calle: json['calle'] ?? '',
      numeroExterior: json['numeroExterior'] ?? '',
      numeroInterior: json['numeroInterior'] ?? '',
      latitud: json['latitud'] ?? '',
      longitud: json['longitud'] ?? '',
    );
  }

  factory AddresModel.fromEmtity(Addres addres){
    return AddresModel(
      idDireccion: addres.idDireccion,
      estado: addres.estado,
      municipio: addres.municipio,
      asentamiento: addres.asentamiento,
      codigoPostal: addres.codigoPostal,
      calle: addres.calle,
      numeroExterior: addres.numeroExterior,
      numeroInterior: addres.numeroInterior,
      latitud: addres.latitud,
      longitud: addres.longitud,
    );
  }
}