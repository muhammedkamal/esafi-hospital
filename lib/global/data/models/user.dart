import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String firstName;

  final String lastName;
  String phoneNumber;
  final String? photoUrl;
  final String idPhotoUrl;
  GeoPoint? location;
  String? fcmToken;
  String? gender;
  String? birthdate;

  List<EmergencyNumber> emergencyNumbers = [];
  User({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.photoUrl,
    required this.idPhotoUrl,
    this.location,
    this.fcmToken,
    this.gender,
    this.birthdate,
    this.emergencyNumbers = const [],
  });
  //serialization
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      photoUrl: data['photoUrl'],
      idPhotoUrl: data['idPhotoUrl'],
      location: data['location'],
      fcmToken: data['fcmToken'],
      gender: data['gender'],
      birthdate: data['birthdate'],
      emergencyNumbers: data['emergencyNumbers'] != null
          ? List<EmergencyNumber>.from(
              data['emergencyNumbers'].map(
                (dynamic x) => EmergencyNumber.fromMap(x),
              ),
            )
          : [],
    );
  }

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data());
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return User.fromMap(data);
  }
  //deserialization
  Map<String, dynamic> toMap() {
    return {
      // 'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'idPhotoUrl': idPhotoUrl,
      'location': location,
      'fcmToken': fcmToken,
      'gender': gender,
      'birthdate': birthdate,
    };
  }
}

class EmergencyNumber {
  final String name;
  final String phoneNumber;
  EmergencyNumber({
    required this.name,
    required this.phoneNumber,
  });
  //serialization
  factory EmergencyNumber.fromMap(Map<String, dynamic> data) {
    return EmergencyNumber(
      name: data['name'],
      phoneNumber: data['phoneNumber'],
    );
  }
  //deserialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
