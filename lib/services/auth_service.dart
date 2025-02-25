import 'package:pfe_coashing_app/global/global_controller.dart';
import 'package:pfe_coashing_app/models/user.dart';
import 'package:pfe_coashing_app/services/global/api_requests.dart';
import 'package:pfe_coashing_app/services/global/api_response.dart';
import 'package:pfe_coashing_app/services/storage_service.dart';

class AuthService {
  final APIRequest _api = APIRequest();

  Future<APIResponse> login(String email, String password) async {
    try {
      final response = await _api.getAPIRequest(
        method: APIMethod.post,
        path: '/auth/local',
        body: {
          'identifier': email,
          'password': password,
        },
      );

      if (!response.isError && response.data != null) {
        final String? token = response.data['jwt'];
        if (token != null) {
          // Store token both in preferences and GlobalController
          await StorageService.saveToken(token);
          GlobalController.token = token;
          
          // If user data is available in response, store it
          if (response.data['user'] != null) {
            GlobalController.currentUser = User.fromJson(response.data['user']);
          }
        }
      }
      
      return response;
    } catch (e) {
      return APIResponse(
        isError: true,
        errorMessage: e.toString(),
        status: null
      );
    }
  }

  Future<APIResponse> register(String username, String email, String password,double heigth,double weight) async {
    try {
      final response = await _api.getAPIRequest(
        method: APIMethod.post,
        path: '/auth/local/register',
        body: {
          'username': username,
          'email': email,
          'password': password,
          'heigth':heigth,
          'weight':weight
        },
      );

      if (!response.isError && response.data != null) {
        final String? token = response.data['jwt'];
        if (token != null) {
          // Store token both in preferences and GlobalController
          await StorageService.saveToken(token);
          GlobalController.token = token;
          
          // If user data is available in response, store it
          if (response.data['user'] != null) {
            GlobalController.currentUser = User.fromJson(response.data['user']);
          }
        }
      }
      
      return response;
    } catch (e) {
      return APIResponse(
        isError: true,
        errorMessage: e.toString(),
        status: null
      );
    }
  }
  Future<APIResponse> getProfile() async {
    try {
      final response = await _api.getAPIRequest(
        method: APIMethod.get,
        path: '/users/me',
      );

      if (!response.isError && response.data != null) {
        GlobalController.currentUser = User.fromJson(response.data);
      }
      
      return response;
    } catch (e) {
      return APIResponse(
        isError: true,
        errorMessage: e.toString(),
        status: null
      );
    }
  }

  Future<void> logout() async {
    await StorageService.removeToken();
    GlobalController.clearSession();
  }

  Future<bool> validateToken() async {
    try {
      final response = await getProfile();
      return !response.isError;
    } catch (e) {
      return false;
    }
  }

  
}
