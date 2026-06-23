import 'package:flutter/material.dart';
import 'package:flutter_gram_app/screens/login_screen.dart';

import '../core/utils/app_size.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // Auth service instance
  final AuthService authService = AuthService();
  final FocusNode _passwordFocusNode = FocusNode();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool showPasswordRequirements = false;

  // Real-time evaluation variables for password rules
  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_checkPasswordStrength);

    
    _passwordFocusNode.addListener(() {
      setState(() {
        showPasswordRequirements = _passwordFocusNode.hasFocus;
      });
    });
  }

  void _checkPasswordStrength() {
    final value = passwordController.text;
    setState(() {
      hasMinLength = value.length >= 8;
      hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
      hasLowercase = RegExp(r'[a-z]').hasMatch(value);
      hasNumber = RegExp(r'[0-9]').hasMatch(value);
      hasSpecialChar = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value);
    });
  }

  Future<void> registerUser() async {
    final mobile = mobileController.text.trim();
    final password = passwordController.text.trim();

    final isRegistered = await authService.registerUser(
      mobile: mobile,
      password: password,
    );

    if (!isRegistered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Mobile number already registered',
          ),
          backgroundColor: Colors.redAccent.shade400,
        ),
      );
      return;
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Registration Successful! 🎉',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const InstagramLoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.removeListener(_checkPasswordStrength);
    _passwordFocusNode.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordValid = hasMinLength &&
        hasUppercase &&
        hasLowercase &&
        hasNumber &&
        hasSpecialChar;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.wp(context, 0.06),
              vertical: AppSize.hp(context, 0.05),
            ),

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(
                      // fontSize: 28,
                      fontSize: AppSize.wp(context, 0.07),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: TextStyle(
                      // fontSize: 16,
                      fontSize: AppSize.wp(context, 0.04),
                      color: Colors.grey.shade600,
                    ),
                  ),
                  // const SizedBox(height: 36),
                  SizedBox(
                    height: AppSize.hp(context, 0.04),
                  ),

                  // Mobile Field
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration(
                      hint: 'Mobile Number',
                      icon: Icons.phone_android_rounded,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 20),
                  SizedBox(
                    height: AppSize.hp(context, 0.025),
                  ),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: obscurePassword,
                    decoration: _inputDecoration(
                      hint: 'Password',
                      icon: Icons.lock_outline_rounded,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            setState(() => obscurePassword = !obscurePassword),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Enter password';
                      if (!isPasswordValid) return 'Password is too weak';
                      return null;
                    },
                  ),

                  // Animated modern checklist container
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: showPasswordRequirements
                        ? Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password Requirements:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _widgetPaaswordRequirements(
                                        '8+ Chars', hasMinLength),
                                    _widgetPaaswordRequirements(
                                        'ABC (Upper)', hasUppercase),
                                    _widgetPaaswordRequirements(
                                        'abc (Lower)', hasLowercase),
                                    _widgetPaaswordRequirements(
                                        '123 (Number)', hasNumber),
                                    Text(
                                      '@#\$ (Special)',
                                      style: TextStyle(
                                        color: hasSpecialChar
                                            ? Colors.green.shade700
                                            : Colors.grey.shade500,
                                        fontWeight: hasSpecialChar
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ), // Handled via helper method below cleanly
                                  ].map((w) {
                                    if (w is Text) {
                                      // Custom fallback or just use helper for all:
                                      return _widgetPaaswordRequirements(
                                          'Special (@#\$)', hasSpecialChar);
                                    }
                                    return w;
                                  }).toList(),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: obscureConfirmPassword,
                    decoration: _inputDecoration(
                      hint: 'Confirm Password',
                      icon: Icons.lock_reset_rounded,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(() =>
                            obscureConfirmPassword = !obscureConfirmPassword),
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 40),
                  SizedBox(
                    height: AppSize.hp(context, 0.05),
                  ),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: AppSize.hp(context, 0.065),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            // fontSize: 16,

                            fontSize: AppSize.wp(context, 0.04),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Footer Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const InstagramLoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blueAccent.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 22),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.blueAccent.shade200, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }

  // Beautiful modern clean requirement chip
  Widget _widgetPaaswordRequirements(String text, bool isMet) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isMet ? Colors.green.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isMet ? Colors.green.shade200 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isMet ? Colors.green.shade600 : Colors.grey.shade400,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
              color: isMet ? Colors.green.shade700 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
