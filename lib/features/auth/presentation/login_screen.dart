import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_project/core/theme/color.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/features/auth/data/auth_services.dart';
import 'package:inventory_project/features/auth/presentation/forgot_password.dart';
import 'package:inventory_project/features/auth/presentation/register_screen.dart';
import 'package:inventory_project/features/auth/presentation/widget/custom_test_field.dart';
import 'package:inventory_project/features/inventory/presentation/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      body: SafeArea(
          child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                'assets/images/login.svg',
                height: 250,
              ),
            ),
          ),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Login',
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
          const SizedBox(height: 11),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    )),
                child: Text(
                  'Forgot Password?',
                  style: AppTypography.regular12.copyWith(
                      fontWeight: FontWeight.w600, color: AppColor.secondary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () async {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HomeScreen(),
                //     ));
                if (_key.currentState!.validate()) {
                  try {
                    var result = await AuthService.signIn(
                        _emailController.text, _passwordController.text);
                    Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.message!)));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('error')));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              child: Text(
                'Login',
                style: AppTypography.buttons.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'New to Terature',
                style: AppTypography.regular12,
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                },
                child: Text(
                  'Register',
                  style: AppTypography.regular12.copyWith(
                      fontWeight: FontWeight.w600, color: AppColor.secondary),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
