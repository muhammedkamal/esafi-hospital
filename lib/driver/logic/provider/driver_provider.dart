import 'package:admin/global/services/auth_service.dart';
import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/model/driver.dart';



class DriverProvider {
  factory DriverProvider() => DriverProvider._internal();
  DriverProvider._internal();

  List<AmbulanceDriver> driver = [];
  Future<List<AmbulanceDriver>> getDriver() async {
    QuerySnapshot driverSnaps =
        await FirestoreHelper.getDocumentsFuture('ambulance_drivers');
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
    data.remove('email');
    DocumentReference driver =
        await FirestoreHelper.addDocument('ambulance_driver', data);
    AuthService().registerUsingEmailAndPassword({
      'email': email,
      'password': password,
      'driverId': driver.id,
      'name': data['name'] + " Driver",
    }, collection: 'hospitals_empolyees');
  }
}
