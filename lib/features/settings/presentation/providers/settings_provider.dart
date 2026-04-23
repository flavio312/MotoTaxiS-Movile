import 'package:flutter/foundation.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_me.dart';

class UserProfileProvider extends ChangeNotifier {
  final GetMe getMe;

  UserProfileProvider({required this.getMe});

  UserProfile? _profile;
  bool _isLoading = false;
  String? _error;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProfile(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await getMe(token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}