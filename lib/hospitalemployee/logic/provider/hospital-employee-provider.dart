import 'package:admin/global/data/models/hospitals.dart';
import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HospitalEmployeeProvider {
  factory HospitalEmployeeProvider() => HospitalEmployeeProvider._internal();
  HospitalEmployeeProvider._internal();

  List<HospitalEmployee> hospitalemployee = [];

  Future<List<HospitalEmployee>> getHospitalEmployee(hospitalID) async {
    QuerySnapshot hospitalemployeeSnaps =
        await FirestoreHelper.getDocumentsFuture(
         'hospitals_empolyees',
         'hospitalId',
          hospitalID,
        );
      hospitalemployeeSnaps.docs.forEach((element) {
      hospitalemployee.add(HospitalEmployee.fromSnapshot(element));
    });
    return hospitalemployee;
  }

  Future<void> deletehospitalemployee (String uid) async {
    await FirestoreHelper.deleteDocument('hospitalemployee', uid);
  }

  Future<void> updatehospitalemployee (String uid, Map<String, dynamic> data) async {
    await FirestoreHelper.updateDocument('hospitalemployee', uid, data);
  }
}
