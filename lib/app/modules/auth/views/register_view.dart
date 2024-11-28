import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'dart:math' as math;

class RegisterView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController(); // Thêm controller cho displayName

  final _formKey = GlobalKey<FormState>();

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // App Logo
                 Image.asset(
                   'assets/images/logo.png', // Replace with your app's logo
                   height: 150,
                 ),
                  const SizedBox(height: 30),
                  // Email Input
                  TextFormField(
                    controller: emailController,
                    validator: validateInput,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
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
                  TextFormField(
                    controller: passwordController,
                    validator: validateInput,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
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
                  const SizedBox(height: 20),
                  // Display Name Input (Mới thêm vào)
                  TextFormField(
                    controller: displayNameController,
                    validator: validateInput,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Display Name',
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ),
                  const SizedBox(height: 30),
        
                  // Hiển thị trạng thái loading hoặc nút Register
                  Obx(() {
                    return authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                authController.register(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  displayNameController.text.trim(), // Gửi displayName vào hàm register
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
                            child: const Text('Register',
                                style: TextStyle(color: Colors.white)),
                          );
                  }),
        
                  const SizedBox(height: 10),
                  // Login Button
                  TextButton(
                    onPressed: () {
                      // Điều hướng trở lại màn hình login
                      Get.back();
                    },
                    child: const Text(
                      'Already have an account? Login',
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
        ),
      ),
    );
  }
}
