import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'dart:math' as math;

class AuthView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validator cho các trường nhập
  String? validateInput(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // App Logo
              Transform.rotate(
                angle: 90 * (math.pi / 180),
                child: Image.asset(
                  'assets/images/logo.png', // Replace with your app's logo
                  height: 150,
                ),
              ),
              const SizedBox(height: 30),
              // Email Input
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  labelText: 'Email',
                  errorText: validateInput(emailController.text),
                  hintStyle: theme.textTheme.displayLarge?.copyWith(
                    color: Colors.blue,
                    fontSize: 12.sp,
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors
                          .grey, // Màu viền khi TextField đang không được chọn
                      width: .5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue, // Màu viền khi TextField đang được chọn
                      width: 2.0,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              const SizedBox(height: 20),
              // Password Input
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  errorText: validateInput(passwordController.text),
                  hintStyle: theme.textTheme.displayLarge?.copyWith(
                    color: Colors.black45,
                    fontSize: 12.sp,
                  ),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors
                          .grey, // Màu viền khi TextField đang không được chọn
                      width: .5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue, // Màu viền khi TextField đang được chọn
                      width: 2.0,
                    ),
                  ),
                ),
                obscureText: true,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              const SizedBox(height: 30),

              // Hiển thị trạng thái loading hoặc nút Login
              Obx(() {
                return authController.isLoading.value
                    ? const CircularProgressIndicator() // Hiển thị loading
                    : ElevatedButton(
                        onPressed: () {
                          if (validateInput(emailController.text) == null &&
                              validateInput(passwordController.text) == null) {
                            authController.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          } else {
                            Get.snackbar(
                                'Error', 'Please fill in all fields.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text('Login',
                            style: TextStyle(color: Colors.white)),
                      );
              }),

              const SizedBox(height: 10),
              // Register Button
              TextButton(
                onPressed: () {
                  if (validateInput(emailController.text) == null &&
                      validateInput(passwordController.text) == null) {
                    authController.register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  } else {
                    Get.snackbar('Error', 'Please fill in all fields.');
                  }
                },
                child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
