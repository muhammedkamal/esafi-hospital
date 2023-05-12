import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/hospitals.dart';
import '../../providers/hospital_provider.dart';

part 'single_hospital_state.dart';

class SingleHospitalCubit extends Cubit<SingleHospitalState> {
  Hospital? hospital;
  SingleHospitalCubit() : super(SingleHospitalControlledState(null));

  Future<void> getHospital(String hospitalId) async {
    if (hospital != null) {
      emit(state);
    } else {
      hospital = await HospitalsProvider().getHospital(hospitalId);
      print(hospital!.toMap());
      emit(SingleHospitalControlledState(hospital!));
    }
  }

  Future<void> addDriverToHospital(Map<String, dynamic> data) async {
    await HospitalsProvider().addDriverToHospital(data);
    hospital!.drivers!.add(AmbulanceDriver.fromMap(data));
    emit(SingleHospitalControlledState(hospital!));
  }
}
