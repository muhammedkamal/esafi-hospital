import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../global/data/models/hospitals.dart';
import '../providers/ambulance_providers.dart';

part 'ambulances_event.dart';
part 'ambulances_state.dart';

class AmbulancesBloc extends Bloc<AmbulancesEvent, AmbulancesState> {
  AmbulancesBloc() : super(AmbulancesInitial()) {
    on<AmbulancesEvent>((event, emit) async {
      try {
        if (event is DeleteAmbulances) {
          emit(AmbulancesLoading());
          await AmbulancesProvider().deleteAmbulance(event.uid);
        } else if (event is UpdateAmbulance) {
          emit(AmbulancesLoading());
          await AmbulancesProvider()
              .updateAmbulance(event.id, event.updated.toMap());
          List<Ambulance> ambulances = await AmbulancesProvider()
              .getAmbulances(event.updated.hospitalId);
          emit(AmbulancesLoaded(ambulances));
        }
      } catch (e) {
        emit(AmbulancesLoadingError(e.toString()));
      }
    });
  }
}
