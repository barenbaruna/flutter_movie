import 'package:flutter/material.dart';
import 'package:flutter_movie/core/session_manager.dart';
import 'package:flutter_movie/ui/custom_colors.dart';
import '../../../repo/film_assets.dart';

class ProfilePage extends StatelessWidget {
  final sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    final firstName = sessionManager.getActiveFirstName();
    final lastName = sessionManager.getActiveLastName();
    final email = sessionManager.getActiveEmail();
    final ultah = sessionManager.getActiveUserBirth();
    final bio = sessionManager.getActiveUserBio();
    final avatarFilename = getAvatarFilename();
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.primary2,
      ),
      backgroundColor: CustomColors.primary2,
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$profileImage/$avatarFilename'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Warna overlay gelap
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * .500,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundImage:
                        NetworkImage('$profileImage/$avatarFilename'),
                      ),
                      SizedBox(height: 30),
                      Text(
                        '$firstName $lastName',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.secondary1,
                        ),
                      ),

                      SizedBox(height: 5),
                      Text(
                        '$ultah',
                        style: TextStyle(
                          fontSize: 20,
                          color: CustomColors.secondary1,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$email',
                        style: TextStyle(
                          fontSize: 20,
                          color: CustomColors.secondary1,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$bio',
                        style: TextStyle(
                          fontSize: 20,
                          color: CustomColors.secondary1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}