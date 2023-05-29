import 'package:admin/global/data/models/hospitals.dart';

import 'package:equatable/src/equatable.dart';

// part of 'ambulance_block.dart';

abstract class AmbulanceState extends Equatable {
  const AmbulanceState();

  @override
  List<Object> get props => [];
}

class AmbulancesInitial extends AmbulanceState{}

class AmbulancesLoading extends AmbulanceState{}

class AmbulancesLoaded extends AmbulanceState{
  final List<Ambulance>ambulances;

  AmbulancesLoaded(this.ambulances);
  
  @override
  List<Object> get props => [ambulances];
}

class AmbulancesLoadingError extends AmbulanceState {
  final String message;

  AmbulancesLoadingError(this.message);

  @override
  List<Object> get props => [message];
}


