import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../global/data/models/hospitals.dart';


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
}
