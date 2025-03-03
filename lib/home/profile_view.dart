import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/style.dart';
import 'package:pfe_coashing_app/home/widgets/fit_details_container.dart';
import 'package:pfe_coashing_app/home/widgets/profile_list_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final heigthScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            //   color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        
       
      ),*/
      body: SafeArea(
        child: Padding(
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
                    backgroundImage: AssetImage('assets/images/heart-rate.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Cristiano Ronaldo",
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
                      subtitle: "187 cm",
                      leading: Icon(Icons.height),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing between the ListTiles
                  Expanded(
                    child: ProfileListTile(
                      title: "Weight",
                      subtitle: "75 kg",
                      leading: Icon(Icons.fitness_center_sharp),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    ),
                  ),
                ],
              ),
              ProfileListTile(
                title: "Email",
                subtitle: "cristiano@gmail.com",
                leading: Icon(Icons.email),
              ),
              ProfileListTile(
                title: "User Name",
                subtitle: "Cr7",
                leading: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
