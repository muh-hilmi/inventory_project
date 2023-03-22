import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory_project/features/auth/data/auth_services.dart';
import 'package:inventory_project/features/auth/presentation/login_screen.dart';
import 'package:inventory_project/features/inventory/presentation/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.firebaseUserStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return HomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
