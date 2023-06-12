import 'package:admin/global/utlis/helpers/firestore_helper.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/ambulance_request.dart';
import '../providers/requests_provider.dart';

part 'requests_handler_state.dart';

class RequestsHandlerCubit extends Cubit<RequestsHandlerState> {
  RequestsHandlerCubit() : super(RequestsHandlerMangedState(null));
  List<AmbulanceRequest> requests = [];
  List<String> cancelledRequests = [];
  Future<void> getRequests(String hospitalId) async {
    requests = await RequestsProvider().getRequests(hospitalId);

    FirestoreHelper.getDocumentsWithCondition(
            'ambulance_requests', 'status', 'pending')
        .listen((event) async {
      requests = await RequestsProvider().getRequests(hospitalId);
      // print(requests);
      event.docs
          .map((e) => AmbulanceRequest.fromFirestore(e))
          .forEach((element) {
        if (requests.where((req) => element.id == req.id).isNotEmpty) {
          requests.removeWhere((req) => element.id == req.id);
        }
        requests.add(element);
        FirestoreHelper.getDocumentByIdStream('ambulance_requests', element.id!)
            .listen((event) {
          requests.removeWhere((element) => element.id == event.id);
          requests.add(AmbulanceRequest.fromFirestore(event));
          requests
              .removeWhere((element) => cancelledRequests.contains(element.id));
          emit(RequestsHandlerMangedState(requests.reversed.toList()));
        });
      });
      requests.removeWhere((element) => cancelledRequests.contains(element.id));
      emit(RequestsHandlerMangedState(requests.reversed.toList()));
    });
  }

  Future<void> acceptRequest(
      String requestId, String ambulanceId, String hospitalId,
      {bool emergency = false}) async {
    await RequestsProvider().acceptRequest(requestId, ambulanceId, hospitalId,
        emergency: emergency);
  }

  void cancelRequest(requestId) {
    cancelledRequests.add(requestId);
    requests.removeWhere((element) => element.id == requestId);
    emit(RequestsHandlerMangedState(requests.reversed.toList()));
  }
}
