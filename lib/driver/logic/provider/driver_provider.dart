import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/model/driver.dart';

class DriverProvider {
  factory DriverProvider() => DriverProvider._internal();
  DriverProvider._internal();

  List<AmbulanceDriver> driver = [];
  Future<List<AmbulanceDriver>> getDriver(String hospitalID) async {
    QuerySnapshot driverSnaps =
        await FirestoreHelper.getDocumentsWithConditionFuture(
      'ambulance_drivers',
      'hospitalId',
      hospitalID,
    );
    driverSnaps.docs.forEach((element) {
      driver.add(AmbulanceDriver.fromSnapshot(element));
    });
    return driver;
  }

  Future<void> deleteDriver(String id) async {
    await FirestoreHelper.deleteDocument('ambulance_drivers', id);
  }

  Future<void> updateDriver(String id, Map<String, dynamic> data) async {
    await FirestoreHelper.updateDocument('ambulance_drivers', id, data);
  }

  Future<void> createDriver(Map<String, dynamic> data) async {
    String email = data['email'];
    String password = data['password'];
    data.remove('password');

    UserCredential? _userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirestoreHelper.addDocumentWithId(
        'ambulance_drivers', _userCredential.user!.uid, data);
    return;
  }
}
