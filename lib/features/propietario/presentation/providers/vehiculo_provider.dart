import 'package:flutter/material.dart';
import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';
import '../../domain/usecases/register_vehiculo.dart';
import '../../domain/usecases/get_vehiculos.dart';
import '../../domain/usecases/change_vehiculo_status.dart';
import '../../domain/usecases/update_vehiculo.dart';

class VehiculoProvider extends ChangeNotifier {
  final RegisterVehiculo registerVehiculo;
  final GetVehiculos getVehiculos;
  final ChangeVehiculoStatus changeVehiculoStatus;
  final UpdateVehiculo updateVehiculo;

  VehiculoProvider({
    required this.registerVehiculo,
    required this.getVehiculos,
    required this.changeVehiculoStatus,
    required this.updateVehiculo,});

  List<VehiculoModel> _vehiculos = [];
  bool _isLoading = false;
  String? _error;

  List<VehiculoModel> get vehiculos => _vehiculos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> register({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await registerVehiculo(data: data, token: token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadVehiculos(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _vehiculos = await getVehiculos(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}