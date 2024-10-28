import 'package:employee_management_app/views/homescreen.dart';
import 'package:employee_management_app/views/loginscreen.dart';
import 'package:employee_management_app/views/signupscreen.dart';
import 'package:employee_management_app/views/skipscreen.dart';
import 'package:employee_management_app/views/splashscreen.dart';
import 'package:employee_management_app/views/supervisorHomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/empcontroller.dart';
import 'controller/service/authservice.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthService());
  Get.put(EmployeeController());
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812), // Example size
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/skip',
          page: () => SkipScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/signUp',
          page: () => SignupScreen(),
        ),
        GetPage(
          name: '/supervisorScreen',
          page: () => SupervisorHomeScreen(),
        )
      ],
    );
  }
}
