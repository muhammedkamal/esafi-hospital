part of 'single_hospital_cubit.dart';

abstract class SingleHospitalState {
  const SingleHospitalState(this.hospital);
  final Hospital? hospital;
}

class SingleHospitalControlledState extends SingleHospitalState {
  SingleHospitalControlledState(Hospital? hospital) : super(hospital);
}


