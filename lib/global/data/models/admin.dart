import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String id;
  String name;
  final String email;
  final String? hospitalId;

  Admin({
    required this.email,
    required this.name,
    required this.id,
    this.hospitalId,
  });

  factory Admin.fromMap(Map<String, dynamic> data) {
    return Admin(
      email: data['email'],
      name: data['name'],
      id: data['uid'],
      hospitalId: data['hospitalId'],
    );
  }

  factory Admin.fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data());
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return Admin.fromMap(data);
  }
}
