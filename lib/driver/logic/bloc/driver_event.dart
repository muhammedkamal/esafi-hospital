part of 'driver_bloc.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

class LoadDriver extends DriverEvent {}

class AddDriver extends DriverEvent {
  final Map<String, dynamic> data;

  AddDriver(this.data);

  @override
  List<Object> get props => [data];
}

class DeleteDriver extends DriverEvent {
  final String id;

  DeleteDriver(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateDriver extends DriverEvent {
  final String id;
  final AmbulanceDriver updated;

  UpdateDriver(this.id, this.updated);

  @override
  List<Object> get props => [id, updated];
}
