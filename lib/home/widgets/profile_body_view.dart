import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/style.dart';
import 'package:pfe_coashing_app/home/widgets/fit_details_container.dart';
import 'package:pfe_coashing_app/home/widgets/profile_list_tile.dart';

class ProfileBodyView extends StatelessWidget {
  const ProfileBodyView({
    super.key,
    required this.heigthScreen,
    required this.colorScheme,
    this.imageUrl,
    required this.userName,
    required this.email,
    required this.height,
    required this.weight,
  });

  final double heigthScreen;
  final ColorScheme colorScheme;
  final String? imageUrl;
  final String userName;
  final String email;
  final String height;
  final String weight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors
                      .primaryColor, // Change this to your desired border color
                  width: 3.0, // Adjust the border width
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imageUrl??'assets/images/heart-rate.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: Text(
              userName,
              style: TextStyles.mainBoldStyle,
            ),
          ),
          Center(
            child: Text(
              "Fitness Athlete",
              style: TextStyles.secondaryNormalStyle,
            ),
          ),
          FitDetailsContainer(
            heigthScreen: heigthScreen,
            colorScheme: colorScheme,
          ),
          SizedBox(
            height: heigthScreen * 0.02,
          ),
          Text(
            "Personal Information",
            style: TextStyles.mainBoldStyle,
          ),
          Row(
            children: [
              Expanded(
                child: ProfileListTile(
                  title: "Height",
                  subtitle: "$height cm",
                  leading: Icon(Icons.height),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4),
                ),
              ),
              SizedBox(width: 10), // Add some spacing between the ListTiles
              Expanded(
                child: ProfileListTile(
                  title: "Weight",
                  subtitle: "$weight kg",
                  leading: Icon(Icons.fitness_center_sharp),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4),
                ),
              ),
            ],
          ),
          ProfileListTile(
            title: "Email",
            subtitle: email,
            leading: Icon(Icons.email),
          ),
          ProfileListTile(
            title: "User Name",
            subtitle: userName,
            leading: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}