import 'package:dio/dio.dart';
import 'package:pfe_coashing_app/global/global_controller.dart';
import 'package:pfe_coashing_app/models/user.dart';
import 'package:pfe_coashing_app/providers/user_provider.dart';
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
          isError: true, errorMessage: e.toString(), status: null);
    }
  }

  Future<APIResponse> register(String username, String email, String password,
      double height, double weight, Role role) async {
    try {
      final response = await _api.getAPIRequest(
        method: APIMethod.post,
        path: '/auth/local/register',
        body: {
          'username': username,
          'email': email,
          'password': password,
          'height': height,
          'weight': weight,
          'userRole': role.toString().split('.').last, // Add the role field
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
            UserProvider.user =  GlobalController.currentUser;
          }
        } else {
          print('Register error: ${response.errorMessage}');
        }
      }

      return response;
    } catch (e) {
      return APIResponse(
          isError: true, errorMessage: e.toString(), status: null);
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
          isError: true, errorMessage: e.toString(), status: null);
    }
  }

  Future<APIResponse> getCurrentUser() async {
    try {
      final response = await _api.getAPIRequest(
        method: APIMethod.get,
        path: '/users/me',
      );

      if (!response.isError && response.data != null) {
        // Parse and store the user data
        final user = User.fromJson(response.data);
        GlobalController.currentUser = user;
        UserProvider.user = user;

        // Return the User object in the APIResponse
        return APIResponse(
          isError: false,
          data: user,
          status: response.status,
        );
      }

      return APIResponse(
        isError: true,
        errorMessage: response.errorMessage ?? 'Failed to fetch user data',
        status: response.status,
      );
    } catch (e) {
      return APIResponse(
        isError: true,
        errorMessage: e.toString(),
        status: null,
      );
    }
  }

  Future<APIResponse> updateProfile(Map<String, dynamic> userData) async {
    try {
      final token = GlobalController.token; // Retrieve the token
      if (token == null) {
        return APIResponse(
          isError: true,
          errorMessage: 'Unauthorized: No token found',
          status: 401,
        );
      }

      final response = await _api.getAPIRequest(
        method: APIMethod.put,
        path: '/users/${UserProvider.user!.id}',
        body: userData,
        headers: {
          'Authorization': 'Bearer $token', // Include the token in the headers
        },
      );

      if (!response.isError && response.data != null) {
        final updatedUser = User.fromJson(response.data);

        // Update the global and provider user data
        UserProvider.user = updatedUser;
        GlobalController.currentUser = updatedUser;

        return APIResponse(
          isError: false,
          data: updatedUser,
          status: response.status,
        );
      }

      return APIResponse(
        isError: true,
        errorMessage: response.errorMessage ?? 'Failed to update profile',
        status: response.status,
      );
    } catch (e) {
      return APIResponse(
        isError: true,
        errorMessage: e.toString(),
        status: null,
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
