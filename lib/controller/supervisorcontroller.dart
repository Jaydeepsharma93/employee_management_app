import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/modelclass.dart';

class SupervisorController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of employee attendance data
  Stream<List<Employee>> getEmployeeDataStream() {
    return _db.collection('employees').snapshots().asyncMap((snapshot) async {
      List<Employee> employeeList = [];

      for (var doc in snapshot.docs) {
        var attendanceCollection = doc.reference.collection('attendance');
        var attendanceSnapshot = await attendanceCollection.get();

        for (var attendanceDoc in attendanceSnapshot.docs) {
          employeeList.add(Employee.fromDocument(attendanceDoc));
        }
      }
      return employeeList;
    });
  }
}
