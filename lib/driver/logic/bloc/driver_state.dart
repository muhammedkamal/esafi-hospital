part of 'driver_bloc.dart';

abstract class DriverState extends Equatable {
  const DriverState();
  
  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final List<AmbulanceDriver> driver;

  DriverLoaded(this.driver);

  @override
  List<Object> get props => [driver];
}

class DriverLoadingError extends DriverState {
  final String message;

  DriverLoadingError(this.message);

  @override
  List<Object> get props => [message];
}
