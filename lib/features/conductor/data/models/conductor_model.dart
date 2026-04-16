import '../../domain/entities/conductor.dart';

class ConductorModel extends Conductor {
  ConductorModel({
    required super.idConductor,
    required super.licencia,
    required super.licenciaFechaExpedicion,
    required super.licenciaFechaVencimiento,
    required super.estatus,
    required super.descripcion,
    required super.jornada,
  });

  factory ConductorModel.fromJson(Map<String, dynamic> json) {
    return ConductorModel(
      idConductor: json['idConductor'] ?? 0,
      licencia: json['licencia'] ?? '',
      licenciaFechaExpedicion: json['licenciaFechaExpedicion'] ?? '',
      licenciaFechaVencimiento: json['licenciaFechaVencimiento'] ?? '',
      estatus: json['estatus'] ?? '',
      descripcion: json['descripcion'] ?? '',
      jornada: Jornada(
        fechaRegistro: json['jornada']['fechaRegistro'] ?? '',
        fechaInicio: json['jornada']['fechaInicio'] ?? '',
        fechaFin: json['jornada']['fechaFin'] ?? '',
        horario: Horario(
          dias: json['jornada']['horario']['dias'] ?? '',
          horas: json['jornada']['horario']['horas'] ?? '',
        ),
      ),
    );
  }
  factory ConductorModel.fromEntity(Conductor conductor) {
    return ConductorModel(
      idConductor: conductor.idConductor,
      licencia: conductor.licencia,
      licenciaFechaExpedicion: conductor.licenciaFechaExpedicion,
      licenciaFechaVencimiento: conductor.licenciaFechaVencimiento,
      estatus: conductor.estatus,
      descripcion: conductor.descripcion,
      jornada: conductor.jornada,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "licencia": licencia,
      "licenciaFechaExpedicion": licenciaFechaExpedicion,
      "licenciaFechaVencimiento": licenciaFechaVencimiento,
      "estatus": estatus,
      "descripcion": descripcion,
      "jornada": {
        "fechaRegistro": jornada.fechaRegistro,
        "fechaInicio": jornada.fechaInicio,
        "fechaFin": jornada.fechaFin,
        "horario": {
          "dias": jornada.horario.dias,
          "horas": jornada.horario.horas,
        }
      }
    };
  }
}