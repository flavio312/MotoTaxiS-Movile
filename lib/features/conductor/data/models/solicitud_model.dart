
class SolicitudModel {
  final int    idServicio;
  final String conductor;
  final String tipoPaquete;
  final String origen;
  final String destino;

  const SolicitudModel({
    required this.idServicio,
    required this.conductor,
    required this.tipoPaquete,
    required this.origen,
    required this.destino,
  });

  // Mock data para prototipar las vistas
  static List<SolicitudModel> get mockList => [
    const SolicitudModel(
      idServicio: 1,
      conductor: 'Flavio DL',
      tipoPaquete: 'Paqueteria',
      origen: 'Origen',
      destino: 'Destino',
    ),
    const SolicitudModel(
      idServicio: 2,
      conductor: 'Flavio DL',
      tipoPaquete: 'Paqueteria',
      origen: 'Origen',
      destino: 'Destino',
    ),
    const SolicitudModel(
      idServicio: 3,
      conductor: 'Flavio DL',
      tipoPaquete: 'Paqueteria',
      origen: 'Origen',
      destino: 'Destino',
    ),
  ];
}
