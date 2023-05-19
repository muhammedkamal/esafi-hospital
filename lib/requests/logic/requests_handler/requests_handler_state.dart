part of 'requests_handler_cubit.dart';

abstract class RequestsHandlerState {
  const RequestsHandlerState(this.requests);
  final List<AmbulanceRequest>? requests;
}

class RequestsHandlerMangedState extends RequestsHandlerState {
  RequestsHandlerMangedState(List<AmbulanceRequest>? requests)
      : super(requests);
}
