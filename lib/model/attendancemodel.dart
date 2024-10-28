import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  Timestamp checkIn;
  Timestamp checkOut;
  GeoPoint location;

  Attendance({required this.checkIn, required this.checkOut, required this.location});

  factory Attendance.fromDocument(DocumentSnapshot doc) {
    return Attendance(
      checkIn: doc['checkIn'],
      checkOut: doc['checkOut'],
      location: doc['location'],
    );
  }
}
