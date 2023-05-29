import 'package:admin/global/data/models/hospitals.dart';
import 'package:equatable/equatable.dart';

// part of'ambulance_block.dart';


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

class UpdateAmbulance extends AmbulancesEvent{
  final String id;
  final Hospital updated;

  UpdateAmbulance(this.id, this.updated);
  @override
  List<Object> get props => [id, updated];
}


