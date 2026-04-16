import '../entities/conductor.dart';

abstract class ConductorRepository{
  Future<void> registerConductor({
    required Conductor conductor,
    required String token,
  });
}