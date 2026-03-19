import 'package:equatable/equatable.dart';

class Person extends Equatable{
  final int idPersona;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String idSexo;
  final String correoElectronico;
  final String telefono;
  final String fechaNacimiento;

  const Person({
    required this.idPersona,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.idSexo,
    required this.correoElectronico,
    required this.telefono,
    required this.fechaNacimiento,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    idPersona,
    nombre,
    apellidoP,
    apellidoM,
    idSexo,
    correoElectronico,
    telefono,
    fechaNacimiento
  ];
}