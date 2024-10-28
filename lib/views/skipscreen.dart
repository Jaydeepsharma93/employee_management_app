import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SkipScreen extends StatelessWidget {
  const SkipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 305.h,
              width: 448.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/logo.png'),
                      fit: BoxFit.cover)),
            ),
            Center(
              child: InkWell(
                onTap: () => Get.offNamed('/login'),
                 child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 305.h,
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Center(
              child: InkWell(
                onTap: () => Get.offNamed('/signUp'),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 305.h,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.green.shade400, width: 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(fontSize: 15.sp),
                ))
          ],
        ),
      ),
    );
  }
}
