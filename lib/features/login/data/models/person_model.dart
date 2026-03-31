import '../../domain/entities/person.dart';

class PersonModel extends Person{
  const PersonModel({
    required super.idPersona,
    required super.nombre,
    required super.apellidoP,
    required super.apellidoM,
    required super.idSexo,
    required super.correoElectronico,
    required super.telefono,
    required super.fechaNacimiento,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json){
    return PersonModel(
        idPersona: json['idPersona'] is int
            ? json['idPersona']
            : int.tryParse(json['idPersona'].toString()) ?? 0,
        nombre: json['nombre'] ?? '',
        apellidoP: json['apellidoP'] ?? '',
        apellidoM: json['apellidoM'] ?? '',
        idSexo: json['idSexo'] ?? '',
        correoElectronico: json['correoElectronico'] ?? '',
        telefono: json['telefono'] ?? '',
        fechaNacimiento: json['fechaNacimiento'] ?? ''
    );
  }

  factory PersonModel.fromEntity(Person person){
    return PersonModel(
        idPersona: person.idPersona,
        nombre: person.nombre,
        apellidoP: person.apellidoP,
        apellidoM: person.apellidoM,
        idSexo: person.idSexo,
        correoElectronico: person.correoElectronico,
        telefono: person.telefono,
        fechaNacimiento: person.fechaNacimiento
    );
  }
}