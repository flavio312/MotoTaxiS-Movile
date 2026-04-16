import 'package:equatable/equatable.dart';

class Conductor extends Equatable {
  final int idConductor;
  final String licencia;
  final String licenciaFechaExpedicion;
  final String licenciaFechaVencimiento;
  final String estatus;
  final String descripcion;
  final Jornada jornada;

  const Conductor({
    required this.idConductor,
    required this.licencia,
    required this.licenciaFechaExpedicion,
    required this.licenciaFechaVencimiento,
    required this.estatus,
    required this.descripcion,
    required this.jornada,
  });

  Conductor copyWith({
    int? idConductor,
    String? licencia,
    String? licenciaFechaExpedicion,
    String? licenciaFechaVencimiento,
    String? estatus,
    String? descripcion,
    Jornada? jornada,
  }) {
    return Conductor(
      idConductor: idConductor ?? this.idConductor,
      licencia: licencia ?? this.licencia,
      licenciaFechaExpedicion:
      licenciaFechaExpedicion ?? this.licenciaFechaExpedicion,
      licenciaFechaVencimiento:
      licenciaFechaVencimiento ?? this.licenciaFechaVencimiento,
      estatus: estatus ?? this.estatus,
      descripcion: descripcion ?? this.descripcion,
      jornada: jornada ?? this.jornada,
    );
  }

  @override
  List<Object?> get props => [
    idConductor,
    licencia,
    licenciaFechaExpedicion,
    licenciaFechaVencimiento,
    estatus,
    descripcion,
    jornada
  ];
}
class Jornada {
  final String fechaRegistro;
  final String fechaInicio;
  final String fechaFin;
  final Horario horario;

  Jornada({
    required this.fechaRegistro,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horario,
  });

  Jornada copyWith({
    String? fechaRegistro,
    String? fechaInicio,
    String? fechaFin,
    Horario? horario,
  }) {
    return Jornada(
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      horario: horario ?? this.horario,
    );
  }
}

class Horario {
  final String dias;
  final String horas;

  Horario({
    required this.dias,
    required this.horas,
  });

  Horario copyWith({
    String? dias,
    String? horas,
  }) {
    return Horario(
      dias: dias ?? this.dias,
      horas: horas ?? this.horas,
    );
  }
}