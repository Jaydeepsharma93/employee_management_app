import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

class EmployeeController extends GetxController {
  var isCheckedIn = false.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    checkForActiveCheckIn();
  }

  Future<void> checkForActiveCheckIn() async {
    var userId = 'your_user_id'; // Replace with actual user ID
    var attendanceCollection = _db.collection('employees').doc(userId).collection('attendance');

    var snapshot = await attendanceCollection
        .where('checkOut', isEqualTo: null)
        .orderBy('checkIn', descending: true)
        .limit(1)
        .get();

    isCheckedIn.value = snapshot.docs.isNotEmpty;
  }

  Future<void> checkIn(String userId, String employeeName) async {
    await requestLocationPermission();

    if (await Permission.location.isGranted) {
      try {
        var attendanceCollection = _db.collection('employees').doc(userId).collection('attendance');

        // Get today's date as a string in 'yyyy-MM-dd' format
        var today = DateFormat('yyyy-MM-dd').format(DateTime.now());

        // Query for today's check-in record
        var todayCheckInSnapshot = await attendanceCollection
            .where('checkInDate', isEqualTo: today)
            .limit(1)
            .get();

        if (todayCheckInSnapshot.docs.isEmpty) {
          // No check-in for today; proceed with check-in
          Position position = await Geolocator.getCurrentPosition();
          await attendanceCollection.add({
            'checkIn': FieldValue.serverTimestamp(),
            'checkInDate': today, // Store date in 'yyyy-MM-dd' format for daily check
            'checkOut': null,
            'employeeName': employeeName,
            'location': GeoPoint(position.latitude, position.longitude),
          });
          isCheckedIn.value = true;
          Get.snackbar("Success", "Check-in successful");
        } else {
          // Already checked in today
          Get.snackbar("Info", "You have already checked in today.");
        }
      } catch (e) {
        Get.snackbar("Error", "Check-in failed: $e");
      }
    } else {
      Get.snackbar("Error", "Check-in failed due to lack of location permission.");
    }
  }

  Future<void> checkOut(String userId) async {
    await requestLocationPermission();

    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition();
        var attendanceCollection = _db.collection('employees').doc(userId).collection('attendance');

        // Retrieve the latest check-in without a check-out
        var snapshot = await attendanceCollection
            .where('checkOut', isEqualTo: null)
            .orderBy('checkIn', descending: true)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          var latestDoc = snapshot.docs.first;

          // Update the check-out field for the latest check-in
          await attendanceCollection.doc(latestDoc.id).update({
            'checkOut': FieldValue.serverTimestamp(),
            'location': GeoPoint(position.latitude, position.longitude),
          });

          isCheckedIn.value = false; // Reset state after successful check-out
          Get.snackbar("Success", "Check-out successful");
        } else {
          Get.snackbar("Error", "No active check-in record found.");
        }
      } catch (e) {
        Get.snackbar("Error", "Check-out failed: $e");
      }
    } else {
      Get.snackbar("Error", "Check-out failed due to lack of location permission.");
    }
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isDenied || status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
      return;
    }
  }

  void _showPermissionDeniedDialog() {
    Get.defaultDialog(
      title: "Location Permission Required",
      middleText: "Please enable location permissions in the app settings to use check-in and check-out features.",
      textConfirm: "Open Settings",
      textCancel: "Cancel",
      onConfirm: () {
        openAppSettings();
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
}
