import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/service/authservice.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthService authService = Get.put(AuthService());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80.h), // Add top padding
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              Container(
                height: 260.h,
                width: 260.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 49.h,
                width: 321.h,
                child: TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              SizedBox(
                height: 50.h,
                width: 321.h,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Password*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    // Handle Forgot Password (if needed)
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Call AuthService login method
                  authService.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 321.h,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.offNamed('/signUp'),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // Add spacing before Google button
              Container(
                height: 49.h,
                width: 321.h,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage('assets/img/google.png'),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    // Implement Google Sign-In (optional)
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}