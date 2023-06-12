import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../driver/data/model/driver.dart';
import '../../../../hospitalemployee/logic/block/hospital-employe-state.dart';
import '../../../data/models/hospitals.dart';
import '../../../utlis/helpers/firestore_helper.dart';
import '../../providers/hospital_provider.dart';

part 'single_hospital_state.dart';

class SingleHospitalCubit extends Cubit<SingleHospitalState> {
  Map<String, Hospital> singleEmployeeScreen = {};
  Hospital? hospital;
  SingleHospitalCubit() : super(SingleHospitalControlledState(null));

  Future<void> getHospital (String hospitalId) async {
    if (hospital != null) {
      emit(state);
    } else {
      print(hospitalId);
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

  Future<void> addAmbulanceToHospital(Map<String, dynamic> data) async {
    await HospitalsProvider().addAmbulanceToHospital(data);
    hospital!.ambulances!.add(Ambulance.fromMap(data));
    emit(SingleHospitalControlledState(hospital!));
  }

  Future<void> addHospitalEmployee(Map<String, dynamic> data) async {
     print(singleEmployeeScreen[data['hospitalId']]!.employees?.length);
    await HospitalsProvider().addHospitalEmployee(data);
    singleEmployeeScreen[data['hospitalId']!] = await HospitalsProvider()
    .getHospital(singleEmployeeScreen[data['hospitalId']]! as String);
    hospital!.drivers!.add(AmbulanceDriver.fromMap(data));
    emit(SingleHospitalControlledState(hospital!));
  }
}