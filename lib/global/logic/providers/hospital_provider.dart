import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../driver/data/model/driver.dart';
import '../../data/models/hospitals.dart';

class HospitalsProvider {
  factory HospitalsProvider() => HospitalsProvider._internal();
  HospitalsProvider._internal();
  Hospital? hospital;
  Future<void> updateHospital(
      String hospitalId, Map<String, dynamic> data) async {
    await FirestoreHelper.updateDocument('hospitals', hospitalId, data,
        merge: true);
  }

  Future<Hospital> getHospital(String hospitalId) async {
    DocumentSnapshot hospitalSnap =
        await FirestoreHelper.getDocumentByIdFuture('hospitals', hospitalId);
    print("----------------> here is the hospo");
    print(hospitalId);
    print(hospitalSnap.data() as Map<String, dynamic>);
    hospital = Hospital.fromSnapshot(hospitalSnap);
    // get hospital employees
    QuerySnapshot employeesSnaps =
        await FirestoreHelper.getDocumentsWithConditionFuture(
      'hospitals_empolyees',
      'hospitalId',
      hospital!.id,
    ); // create hospital in firebase
    print(employeesSnaps);
    hospital!.employees = employeesSnaps.docs
        .map((e) => HospitalEmployee.fromSnapshot(e))
        .toList();

    // get hospital drivers
    QuerySnapshot driversSnaps =
        await FirestoreHelper.getDocumentsWithConditionFuture(
      'ambulance_drivers',
      'hospitalId',
      hospital!.id,
    );
    print(driversSnaps);

    hospital!.drivers =
        driversSnaps.docs.map((e) => AmbulanceDriver.fromSnapshot(e)).toList();

    // get hospital ambulances
    QuerySnapshot ambulancesSnaps =
        await FirestoreHelper.getDocumentsWithConditionFuture(
      'ambulances',
      'hospitalId',
      hospital!.id,
    );
    print(ambulancesSnaps);

    hospital!.ambulances =
        ambulancesSnaps.docs.map((e) => Ambulance.fromSnapshot(e)).toList();
    return hospital!;
  }

  Future<void> addDriverToHospital(Map<String, dynamic> data) async {
    String email = data['email'];
    String password = data['password'];
    data.remove('password');

    UserCredential? _userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirestoreHelper.addDocumentWithId(
        'ambulance_drivers', _userCredential.user!.uid, data);
    hospital = await getHospital(hospital!.id);
    return;
  }

  Future<void> addAmbulanceToHospital(Map<String, dynamic> data) async {
    print(data);
    await FirestoreHelper.addDocumentWithId('ambulances', data['id'], data);
    hospital = await getHospital(data['hospitalId']);
    return;
  }

  // add hospital employee

  Future<void> addHospitalEmployee(Map<String, dynamic> data) async {
    String email = data['email'];
    String password = data['password'];
    data.remove('password');
    data.remove('email');

    UserCredential? _userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirestoreHelper.addDocumentWithId(
        'hospitals_empolyees', _userCredential.user!.uid, data);
    hospital = await getHospital(hospital!.id);
    return;
  }
}