part of 'ambulances_bloc.dart';

abstract class AmbulancesState extends Equatable {
  const AmbulancesState();

  @override
  List<Object> get props => [];
}

class AmbulancesInitial extends AmbulancesState {}

class AmbulancesLoading extends AmbulancesState {}

class AmbulancesLoaded extends AmbulancesState {
  final List<Ambulance> ambulances;

  AmbulancesLoaded(this.ambulances);

  @override
  List<Object> get props => [ambulances];
}

class AmbulancesLoadingError extends AmbulancesState {
  final String message;

  AmbulancesLoadingError(this.message);

  @override
  List<Object> get props => [message];
}
