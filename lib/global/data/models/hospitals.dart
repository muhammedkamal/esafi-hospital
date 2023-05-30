import 'package:admin/driver/data/model/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  final String id;
  String name;
  String phoneNumber;
  GeoPoint? location;
  List<HospitalEmployee>? employees;
  List<AmbulanceDriver>? drivers;
  List<Ambulance>? ambulances;
  Hospital({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.location,
    required this.employees,
  });

  factory Hospital.fromMap(Map<String, dynamic> data) {
    return Hospital(
      id: data['uid'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      location: data['location'],
      employees: data['employees'],
    );
  }
  factory Hospital.fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data());
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return Hospital.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
      'employee': employees,
    };
  }
}

class HospitalEmployee {
  final String id;
  String name;
  String? phoneNumber;
  String email;
  String hospitalId;

  HospitalEmployee({
    required this.id,
    required this.name,
    this.phoneNumber,
    required this.email,
    required this.hospitalId,
  });

  factory HospitalEmployee.fromMap(Map<String, dynamic> data) {
    print(data);
    return HospitalEmployee(
      id: data['uid'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      hospitalId: data['hospitalId'],
    );
  }

  factory HospitalEmployee.fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data());
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return HospitalEmployee.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'hospitalId': hospitalId,
    };
  }
}

class Ambulance {
  String id;
  GeoPoint? currentPosition;
  String hospitalId;
  String? driverId;
  Ambulance({
    required this.id,
    this.currentPosition,
    this.driverId,
    required this.hospitalId,
  });

  // serilzation
  factory Ambulance.fromMap(Map<String, dynamic> data) {
    print("Ambulance ----------------> $data");
    return Ambulance(
      id: data['id'],
      currentPosition: data['position'],
      driverId: data['driverId'],
      hospitalId: data['hospitalId'],
    );
  }

  //from firestore
  factory Ambulance.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Ambulance.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "position": currentPosition,
      "driverId": driverId,
      "hospitalId": "hospitalId",
    };
  }
}
