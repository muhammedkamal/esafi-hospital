import 'package:cloud_firestore/cloud_firestore.dart';

class AmbulanceDriver {
  final String id;
  String name;
  String phoneNumber;
  String? email;
  String hospitalId;
  final String ambulanceId;

  AmbulanceDriver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.hospitalId,
    required this.ambulanceId,
  });

  factory AmbulanceDriver.fromMap(Map<String, dynamic> data) {
    return AmbulanceDriver(
      id: data['uid'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      hospitalId: data['hospitalId'],
      ambulanceId: data['ambulanceId'],
    );
  }

  factory AmbulanceDriver.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return AmbulanceDriver.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'hospitalId': hospitalId,
      'ambulanceId': ambulanceId,
    };
  }
}
