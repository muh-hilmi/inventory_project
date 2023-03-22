import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/core/theme/color.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/features/auth/data/auth_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: AppColor.bgLight,
              child: Center(
                  child: Text(
                'A',
                style: AppTypography.headline
                    .copyWith(fontWeight: FontWeight.w700),
              )),
            ),
            const SizedBox(height: 14),
            Text(
              'email',
              style: AppTypography.regular12,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await AuthService.signOut();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: Text(
                  'Logout',
                  style: AppTypography.buttons.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFirstLetterName(String email) {
    return email[0].characters.first;
  }
}
