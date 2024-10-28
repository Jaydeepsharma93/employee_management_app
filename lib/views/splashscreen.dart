import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 4), () async {
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String role = userDoc['role'] ??
            'employee'; // Default to employee if role is null

        // Navigate based on the user's role
        if (role == 'supervisor') {
          Get.offAllNamed('/supervisorScreen');
        } else {
          Get.offAllNamed('/home');
        }
      } else {
        // If no user is logged in, navigate to skip screen
        Get.offNamed('/skip');
      }
    });

    return Scaffold(
      body: Center(
        child: Container(
          height: 385.h,
          width: 566.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
