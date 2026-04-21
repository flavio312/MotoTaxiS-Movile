
class VehiculoModel {
  final int   idVehiculo;
  final String matricula;
  final String modelo;
  final String color;
  final String estatus;
  final String? conductor;
  final String? fechaAdquisicion;

  const VehiculoModel({
    required this.idVehiculo,
    required this.matricula,
    required this.modelo,
    required this.color,
    required this.estatus,
    this.conductor,
    this.fechaAdquisicion,
  });

  factory VehiculoModel.fromJson(Map<String, dynamic> json) => VehiculoModel(
    idVehiculo:      json['idVehiculo'] as int,
    matricula:       json['matricula'] as String,
    modelo:          json['modelo'] as String,
    color:           json['color'] as String,
    estatus:         json['estatus'] as String,
    conductor:       json['conductor'] as String?,
    fechaAdquisicion: json['fechaAdquisicion'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (idVehiculo != null) 'idVehiculo': idVehiculo,
    'matricula':       matricula,
    'modelo':          modelo,
    'color':           color,
    'estatus':         estatus,
    if (conductor != null) 'conductor': conductor,
    if (fechaAdquisicion != null) 'fechaAdquisicion': fechaAdquisicion,
  };

  // Mock data para prototipar
  static List<VehiculoModel> get mockList => [
    const VehiculoModel(
      idVehiculo: 1,
      matricula: 'ABC-1234',
      modelo: 'Honda CG 150',
      color: 'Rojo',
      estatus: 'Activo',
      conductor: 'DL Flavio',
    ),
    const VehiculoModel(
      idVehiculo: 2,
      matricula: 'XYZ-5678',
      modelo: 'Yamaha FZ 250',
      color: 'Negro',
      estatus: 'Activo',
      conductor: 'Conductor 2',
    ),
  ];
}
