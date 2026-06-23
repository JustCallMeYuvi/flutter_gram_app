import 'package:flutter/material.dart';
import 'package:flutter_gram_app/core/utils/password_helper.dart';

import 'package:hive/hive.dart';

import '../core/utils/app_size.dart';
import 'insta_home_screen.dart';
import 'register_screen.dart';

class InstagramLoginScreen extends StatefulWidget {
  const InstagramLoginScreen({super.key});

  @override
  State<InstagramLoginScreen> createState() => _InstagramLoginScreenState();
}

class _InstagramLoginScreenState extends State<InstagramLoginScreen> {
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  void login() {
    final usersBox = Hive.box('users');

    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();

    final user = usersBox.get(mobile);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found'),
        ),
      );
      return;
    }

    String enteredPassword = PasswordHelper.hashPassword(password);

    if (enteredPassword == user['password']) {
      Hive.box('users').put(
        'isLoggedIn',
        true,
      );
      debugPrint(
        Hive.box('users').get('isLoggedIn'),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const InstaHomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Password'),
        ),
      );
    }
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.wp(context, 0.06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(height: 80),
                  SizedBox(
                    height: AppSize.hp(context, 0.10),
                  ),

                  const Center(
                    child: Text(
                      'Instagram',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 35),
                  SizedBox(
                    height: AppSize.hp(context, 0.04),
                  ),
                  // Mobile Field
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.grey[200]!, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.grey[200]!, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xff3797EF),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Log In Button
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: const Color(0xff9FD1FF),
                      backgroundColor: Colors.blueAccent,

                      elevation: 0,
                      // padding: const EdgeInsets.symmetric(vertical: 14),
                      padding: EdgeInsets.symmetric(
                        vertical: AppSize.hp(context, 0.018),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 30),
                  SizedBox(
                    height: AppSize.hp(context, 0.04),
                  ),

                  // Log in with Facebook
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook,
                        color: Color(0xff3797EF), size: 20),
                    label: const Text(
                      'Log in with Facebook',
                      style: TextStyle(
                        color: Color(0xff3797EF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                          child:
                              Divider(color: Colors.grey[300], thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                          child:
                              Divider(color: Colors.grey[300], thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up.',
                          style: TextStyle(
                            color: Color(0xff3797EF),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Divider(),

                  // Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'Instagram',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
