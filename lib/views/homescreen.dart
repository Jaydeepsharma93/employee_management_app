import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/empcontroller.dart';
import '../controller/service/authservice.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final EmployeeController controller = Get.put(EmployeeController());
  final AuthService authService = Get.put(AuthService());

  // Method to get the formatted current time
  String getCurrentTime() {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  // Method to get the formatted date
  String getCurrentDate() {
    return DateFormat('EEEE, MMM d').format(DateTime.now());
  }

  // Separate animation flags for check-in and check-out buttons
  final RxBool isAnimatingIn = false.obs;
  final RxBool isAnimatingOut = false.obs;

  // Trigger animation based on button type
  void triggerAnimation(String buttonType) {
    if (buttonType == 'in') {
      isAnimatingIn.value = true;
      Future.delayed(Duration(milliseconds: 200), () {
        isAnimatingIn.value = false;
      });
    } else if (buttonType == 'out') {
      isAnimatingOut.value = true;
      Future.delayed(Duration(milliseconds: 200), () {
        isAnimatingOut.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62.h,
        backgroundColor: Colors.green,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: 38.sp,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() => Column(
          children: [
            SizedBox(height: 18.h),
            Text(
              'Hi, ${authService.getUserName()}!', // Change to authService.userName.value if needed
              style: TextStyle(fontSize: 28.sp),
            ),
            SizedBox(height: 80.h),
            Text(
              getCurrentTime(),
              style: TextStyle(
                  fontSize: 44.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              getCurrentDate(),
              style: TextStyle(
                fontSize: 26.sp,
              ),
            ),
            SizedBox(height: 60.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // Pass the userId and the employee name to checkIn
                    controller.checkIn(
                        authService.firebaseUser.value?.uid ?? '',
                        authService.getUserName() // Add the employee name here
                    );
                    triggerAnimation('in');
                  },
                  child: Obx(() => AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    alignment: Alignment.center,
                    height: isAnimatingIn.value ? 110.h : 100.h,
                    width: isAnimatingIn.value ? 110.h : 100.h,
                    color: Colors.green.shade100,
                    child: Text(
                      'In!',
                      style: TextStyle(fontSize: 28.sp),
                    ),
                  )),
                ),
                GestureDetector(
                  onTap: () {
                    controller.checkOut(authService.firebaseUser.value?.uid ?? '');
                    triggerAnimation('out');
                  },
                  child: Obx(() => AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    alignment: Alignment.center,
                    height: isAnimatingOut.value ? 110.h : 100.h,
                    width: isAnimatingOut.value ? 110.h : 100.h,
                    color: Colors.green.shade100,
                    child: Text(
                      'Out!',
                      style: TextStyle(fontSize: 28.sp),
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              controller.isCheckedIn.value
                  ? 'You are currently checked in.'
                  : 'You are currently checked out.',
              style: TextStyle(fontSize: 18.sp),
            ),
          ],
        )),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 45,
                    child: Icon(
                      Icons.person,
                      size: 42.sp,
                    ),
                  ),
                  Spacer(),
                  Obx(() => Text(
                    'Hi, ${authService.userName.value}!', // Ensure you have a proper userName field
                    style: TextStyle(fontSize: 21.sp, color: Colors.white),
                  )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                size: 26.sp,
              ),
              title: Text('Home', style: TextStyle(fontSize: 21.sp)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.backpack_outlined,
                size: 26.sp,
              ),
              title: Text('Issues', style: TextStyle(fontSize: 21.sp)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.note_alt_outlined,
                size: 26.sp,
              ),
              title: Text('Incidents', style: TextStyle(fontSize: 21.sp)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.format_list_numbered_outlined,
                size: 26.sp,
              ),
              title: Text('Leaves', style: TextStyle(fontSize: 21.sp)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.lock_outlined,
                size: 26.sp,
              ),
              title: Text('Change Password', style: TextStyle(fontSize: 21.sp)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 26.sp,
              ),
              title: Text('Log Out', style: TextStyle(fontSize: 21.sp)),
              onTap: () {
                authService.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
