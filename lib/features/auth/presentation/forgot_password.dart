import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_project/core/constants/strings.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/features/auth/presentation/widget/custom_test_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SvgPicture.asset(
                'assets/images/forget_password.svg',
                height: 250,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Forgot\nPassword?',
              style:
                  AppTypography.headline.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              Strings.forgotPassDesc,
              style: AppTypography.regular12,
            ),
          ),
          const SizedBox(height: 20),
          Form(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTestField(
                  controller: _emailController,
                  hintText: 'Email',
                ),
              ],
            ),
          )),
          const SizedBox(height: 20),
          const SizedBox(height: 74),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              child: Text(
                'Submit',
                style: AppTypography.buttons.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
