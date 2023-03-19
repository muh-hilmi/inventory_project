import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_project/core/constants/strings.dart';
import 'package:inventory_project/core/theme/color.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/core/widget/loading_dialog.dart';
import 'package:inventory_project/features/auth/presentation/widget/custom_test_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _key = GlobalKey<FormState>();

  var hidePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                'assets/images/register.svg',
                height: 250,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Register',
              style:
                  AppTypography.headline.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20),
          Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTestField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 20),
                    CustomTestField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: hidePassword,
                      suffixIcon: hidePassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: const Icon(Icons.visibility_off))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: const Icon(Icons.visibility)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              Strings.registerDesc,
              style: AppTypography.regular12,
            ),
          ),
          const SizedBox(height: 74),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              child: Text(
                'Register',
                style: AppTypography.buttons.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Joined us before?',
                style: AppTypography.regular12,
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Login',
                  style: AppTypography.regular12.copyWith(
                      fontWeight: FontWeight.w600, color: AppColor.secondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      )),
    );
  }
}
