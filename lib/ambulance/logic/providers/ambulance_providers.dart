import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/global/data/models/hospitals.dart';

class AmbulancesProvider {
  factory AmbulancesProvider() => AmbulancesProvider._internal();
  AmbulancesProvider._internal();

  List<Ambulance> ambulances = [];

  Future<List<Ambulance>> getAmbulances(String hospitalID) async {
    QuerySnapshot ambulancesSnaps =
        await FirestoreHelper.getDocumentsWithConditionFuture(
      'ambulances',
      'hospitalId',
      hospitalID,
    );
    ambulancesSnaps.docs.forEach((element) {
      ambulances.add(Ambulance.fromSnapshot(element));
    });
    return ambulances;
  }

  Future<void> deleteAmbulance(String id) async {
    await FirestoreHelper.deleteDocument('ambulances', id);
  }

  Future<void> updateAmbulance(String id, Map<String, dynamic> data) async {
    print(data);
    await FirestoreHelper.updateDocument('ambulances', id, data);
  }
}
