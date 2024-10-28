import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/service/authservice.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthService authService = Get.put(AuthService());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxString selectedRole = 'employee'.obs; // Default to "employee"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 160.h),
                Text(
                  'Sign Up for Better Experience',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 50.h,
                  width: 321.h,
                  child: TextField(
                    controller: fullNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Employee Name',
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
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                SizedBox(
                  height: 49.h,
                  width: 321.h,
                  child: TextField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                // Role selection dropdown
                Obx(() => Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton<String>(
                    value: selectedRole.value,
                    items: [
                      DropdownMenuItem(
                        value: 'employee',
                        child: Text('Employee'),
                      ),
                      DropdownMenuItem(
                        value: 'supervisor',
                        child: Text('Supervisor'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        selectedRole.value = value;
                      }
                    },
                  ),
                )),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    // Call signUp function with full name, email, password, and role
                    authService.signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      fullNameController.text.trim(),
                      selectedRole.value, // Pass the selected role
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
                      'Sign Up',
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
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.offNamed('/login'),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
                      // Implement Google Sign-Up (optional)
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
