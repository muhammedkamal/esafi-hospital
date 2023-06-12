part of 'ambulances_bloc.dart';

abstract class AmbulancesEvent extends Equatable {
  const AmbulancesEvent();

  @override
  List<Object> get props => [];
}

class LoadAmbulances extends AmbulancesEvent {}

class DeleteAmbulances extends AmbulancesEvent {
  final String uid;

  DeleteAmbulances(this.uid);

  @override
  List<Object> get props => [uid];
}

class UpdateAmbulance extends AmbulancesEvent {
  final String id;
  final Ambulance updated;

  UpdateAmbulance(this.id, this.updated);
  @override
  List<Object> get props => [id, updated];
}
