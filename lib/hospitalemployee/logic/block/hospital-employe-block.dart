import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global/data/models/hospitals.dart';
import '../../../global/logic/providers/hospital_provider.dart';
import 'hospital-employe-event.dart';
import 'hospital-employe-state.dart';




class HospitalEmployeeBloc extends Bloc<HospitalEmployeeEvent, HospitalEmployeeState> {
  HospitalEmployeeBloc() : super( HospitalEmployeeInitial()) {
    on<HospitalEmployeeEvent>(
      (event, emit) async {
        try {
          if (event is LoadHospitalEmployee) {
            emit(HospitalEmployeeLoading());
           List<HospitalEmployee> hospitalemployee =
                await HospitalsProvider().getHospitals();
            emit(HospitalEmployeeLoaded(hospitalemployee));
            } else if (event is DeleteHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            await HospitalsProvider().deleteHospitals(event.id);
            List<HospitalEmployee> hospitalemployee = await HospitalsProvider().getHospitals();
            emit(HospitalEmployeeLoaded(hospitalemployee));
          } else if (event is UpdateHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            await HospitalsProvider().updateHospitals(event.id, event.updated.toMap());
            List<HospitalEmployee> hospitalemployee = await HospitalsProvider().getHospitals();
            emit(HospitalEmployeeLoaded(hospitalemployee));
          }
        } catch (e) {
          emit(HospitalEmployeeLoadingError(e.toString()));
        }
      },
    );
  }
}