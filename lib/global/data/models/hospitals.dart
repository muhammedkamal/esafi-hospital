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
  String phoneNumber;
  String email;
  String hospitalId;

  HospitalEmployee({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.hospitalId,
  });

  factory HospitalEmployee.fromMap(Map<String, dynamic> data) {
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

class AmbulanceDriver {
  final String id;
  String name;
  String phoneNumber;
  String? email;
  String hospitalId;
  String? ambulanceId;

  AmbulanceDriver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.hospitalId,
    this.ambulanceId,
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

class Ambulance {
  String id;
  GeoPoint? currentPosition;
  String hospitalId;
  String driverId;
  Ambulance({
    required this.id,
    required this.currentPosition,
    required this.driverId,
    required this.hospitalId,
  });

  // serilzation
  factory Ambulance.fromMap(Map<String, dynamic> data) {
    return Ambulance(
      id: data['id'],
      currentPosition: data['position'] != null
          ? GeoPoint(data['poistion'].latitude, data['poistion'].longitude)
          : null,
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
}
