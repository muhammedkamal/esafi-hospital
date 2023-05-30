import 'dart:core';
import 'package:admin/ambulance/logic/block/ambulance_event.dart';
import 'package:admin/ambulance/logic/block/ambulance_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  
import '../../../global/data/models/hospitals.dart';

import 'package:admin/ambulance/logic/providers/ambulance_providers.dart';





class AmbulancesBloc extends Bloc<AmbulancesEvent, AmbulanceState> {
  AmbulancesBloc() : super(AmbulancesInitial()) {
    on<AmbulancesEvent>(
      (event, emit) async {
        try {
          if (event is LoadAmbulances) {
            emit(AmbulancesLoading());
            List<Ambulance> ambulances = await AmbulancesProvider().getAmbulances();
            emit(AmbulancesLoaded(ambulances));
          } else if (event is DeleteAmbulances) {
            emit(AmbulancesLoading());
            await AmbulancesProvider().deleteAmbulance(event.uid);
            List<Ambulance> ambulances = await AmbulancesProvider().getAmbulances();
            emit(AmbulancesLoaded(ambulances));
          } else if (event is UpdateAmbulance) {
            emit(AmbulancesLoading());
            await AmbulancesProvider()
                .updateAmbulance(event.id, event.updated.toMap());
            List<Ambulance> ambulances = await AmbulancesProvider().getAmbulances();
            emit(AmbulancesLoaded(ambulances));
          } 
        } catch (e) {
          rethrow;
          emit(AmbulancesLoadingError(e.toString()));
        }
      },
    );
  }
}
