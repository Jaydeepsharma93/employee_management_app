import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String id;
  final String name;
  final Timestamp? timeIn;
  final Timestamp? timeOut;
  final GeoPoint location;

  Employee({
    required this.id,
    required this.name,
    this.timeIn,
    this.timeOut,
    required this.location,
  });

  // Factory constructor to create an Employee from a Firestore document
  factory Employee.fromDocument(DocumentSnapshot doc) {
    return Employee(
      id: doc.id,
      name: doc['name'] ?? 'Unknown',
      timeIn: doc['timeIn'],
      timeOut: doc['timeOut'],
      location: doc['location'] ?? GeoPoint(0.0, 0.0),
    );
  }

  // Convert Employee object to a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'location': location,
    };
  }
}
