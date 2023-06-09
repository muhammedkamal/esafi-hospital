
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global/data/models/hospitals.dart';
import '../provider/hospital-employee-provider.dart';
import 'hospital-employe-event.dart';
import 'hospital-employe-state.dart';

class HospitalEmployeeBloc extends Bloc<HospitalEmployeeEvent, HospitalEmployeeState> {
  var hospitalID;

  HospitalEmployeeBloc() : super(HospitalEmployeeInitial()) {
    on<HospitalEmployeeEvent>(
      (event, emit) async {
        try {
          if (event is LoadHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            List<HospitalEmployee> hospitalemployee =
                await HospitalEmployeeProvider().getHospitalEmployee(hospitalID);
            emit(HospitalEmployeeLoaded(hospitalemployee));
            } else if (event is DeleteHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            await HospitalEmployeeProvider().deletehospitalemployee(event.id);
            List<HospitalEmployee> hospitalemployee = await HospitalEmployeeProvider().getHospitalEmployee(hospitalID);
            emit(HospitalEmployeeLoaded(hospitalemployee));
          } else if (event is UpdateHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            await HospitalEmployeeProvider().updatehospitalemployee(event.id, event.updated.toMap());
            List<HospitalEmployee> hospitalemployee = await HospitalEmployeeProvider().getHospitalEmployee(hospitalID);
            emit(HospitalEmployeeLoaded(hospitalemployee));
          }else if (event is AddHospitalEmployee) {
          emit(HospitalEmployeeLoading());
          // await HospitalsProvider().addHospitalEmployee(event.data);
          // List<Hospital> hospitalemployee = await HospitalsProvider().getHospital();
          // emit(HospitalEmployeeLoaded(hospital));
        }
        } catch (e) {
          emit(HospitalEmployeeLoadingError(e.toString()));
        }
      },
    );
  }
}
