import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:admin/requests/data/models/ambulance_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RequestsProvider {
  factory RequestsProvider() => RequestsProvider._internal();
  RequestsProvider._internal();

  List<AmbulanceRequest>? requests;

  Future<List<AmbulanceRequest>> getRequests(String hospitalId) async {
    requests = [];
    QuerySnapshot querySnapshot =
        await FirestoreHelper.getDocumentsWithConditionFuture(
            'ambulance_requests', 'hospitalId', hospitalId);
    querySnapshot.docs.forEach((element) {
      requests?.add(AmbulanceRequest.fromFirestore(element));
    });
    return requests ??= [];
  }

  Future<void> acceptRequest(
      String requestId, String ambulanceId, String hospitalId) async {
    await FirestoreHelper.updateDocument(
        'ambulance_requests',
        requestId,
        {
          'status': describeEnum(AmbulanceRequestStatus.accepted),
          'ambulanceId': ambulanceId,
          'hospitalId': hospitalId,
          'acceptedAt': Timestamp.now(),
        },
        merge: true);
  }
}
