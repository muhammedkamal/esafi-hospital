import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../global/data/models/hospitals.dart';
import '../../../global/utlis/helpers/firestore_helper.dart';


class HospitalEmployeeProvider {
  factory HospitalEmployeeProvider() => HospitalEmployeeProvider._internal();
  HospitalEmployeeProvider._internal();

  List<HospitalEmployee> hospitalemployee = [];

  Future<List<HospitalEmployee>> getHospitalEmployee() async {
    QuerySnapshot ahospitalemployeeSnaps =
        await FirestoreHelper.getDocumentsFuture('hospitalemployee');
    ahospitalemployeeSnaps.docs.forEach((element) {
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

  // Future<void> addhospitalemployee (Map<String, dynamic> data) async {
  //   String email = data['email'];
  //   String password = data['password'];
  //   data.remove('password');

  //   UserCredential? _userCredential = await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password);
  //   await FirestoreHelper.addDocumentWithId(
  //       'admins', _userCredential.user!.uid, data);
  //   print("admin added");
  //   return;
 // }
//}
}
