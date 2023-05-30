part of 'single_hospital_cubit.dart';

abstract class SingleHospitalState {
  const SingleHospitalState(this.hospital);
  final Hospital? hospital;

 get hospitalemployee => null;
}


class SingleHospitalControlledState extends SingleHospitalState {
  SingleHospitalControlledState(Hospital? hospital) : super(hospital);
}
