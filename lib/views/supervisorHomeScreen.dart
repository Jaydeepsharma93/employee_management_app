import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/service/authservice.dart';
import '../controller/supervisorcontroller.dart';
import '../model/modelclass.dart';

class SupervisorHomeScreen extends StatelessWidget {
  SupervisorHomeScreen({super.key});

  final AuthService authService = Get.put(AuthService());
  final SupervisorController controller =
      Get.put(SupervisorController());

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
                onPressed: () => Scaffold.of(context).openEndDrawer(),
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
      body: StreamBuilder<List<Employee>>(
        stream: controller.getEmployeeDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No employee data available."));
          }

          final employees = snapshot.data!;

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(employee.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Check-In: ${employee.timeIn?.toDate() ?? 'No record'}"),
                      Text("Check-Out: ${employee.timeOut?.toDate() ?? 'No record'}"),
                      Text("Location: (${employee.location.latitude}, ${employee.location.longitude})"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 45,
                    child: Icon(Icons.person, size: 42.sp),
                  ),
                  Spacer(),
                  Obx(() => Text(
                        'Hi, ${authService.userName.value}!',
                        style: TextStyle(fontSize: 21.sp, color: Colors.white),
                      )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined, size: 26.sp),
              title: Text('Home', style: TextStyle(fontSize: 21.sp)),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: Icon(Icons.logout, size: 26.sp),
              title: Text('Log Out', style: TextStyle(fontSize: 21.sp)),
              onTap: () => authService.logout(),
            ),
          ],
        ),
      ),
    );
  }
}
