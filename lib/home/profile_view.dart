import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/widgets/custom_progress_indicator.dart';
import 'package:pfe_coashing_app/home/edit_profile_view.dart';
import 'package:pfe_coashing_app/home/widgets/profile_body_view.dart';
import 'package:pfe_coashing_app/models/user.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _authService = AuthService();
  bool _isLoading = true;
  User? _user;
  String? _error;
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final response = await _authService.getProfile();

    setState(() {
      _isLoading = false;
      if (!response.isError) {
        _user = User.fromJson(response.data);
      } else {
        _error = response.errorMessage;
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final heigthScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.brightness == Brightness.dark
                ? AppColors.darkBackground
                : AppColors.lightBackground,
            title: Text(
              'Profile',
              style: TextStyle(
                color: colorScheme.brightness == Brightness.dark
                    ? AppColors.lightBackground
                    : AppColors.darkBackground,
                fontSize: 22,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purpleColor,
                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  EditProfileView(),
                  ));
                },
              ),
            ],
          ),
          body: _isLoading
              ? const Center(
                  child: CustomProgressIndicator(),
                )
              : _error != null
                  ? Center(
                      child: Text(_error!),
                    )
                  : ProfileBodyView(
                      heigthScreen: heigthScreen,
                      colorScheme: colorScheme,
                      email: _user!.email,
                      userName: _user!.username,
                      height: _user!.height.toString(),
                      weight: _user!.weight.toString(),
                      role: _user!.role.toString().split('.').last,
                    )),
    );
  }
}
