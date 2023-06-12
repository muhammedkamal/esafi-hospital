part of 'driver_bloc.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

class LoadDriver extends DriverEvent {
  final String hospitalId;

  LoadDriver(this.hospitalId);
}

class AddDriver extends DriverEvent {
  final String hospitalId;
  final Map<String, dynamic> data;

  AddDriver(this.data, this.hospitalId);

  @override
  List<Object> get props => [data];
}

class DeleteDriver extends DriverEvent {
  final String hospitalId;

  DeleteDriver(this.hospitalId);

  @override
  List<Object> get props => [hospitalId];
}

class UpdateDriver extends DriverEvent {
  final String hospitalId;
  final AmbulanceDriver updated;

  UpdateDriver(this.hospitalId, this.updated);

  @override
  List<Object> get props => [hospitalId, updated];
}
