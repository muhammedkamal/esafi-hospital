//part of 'hospital_emplyee_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../global/data/models/hospitals.dart';

abstract class HospitalEmployeeEvent extends Equatable {
  const HospitalEmployeeEvent();

  @override
  List<Object> get props => [];
}

class LoadHospitalEmployee extends HospitalEmployeeEvent {}

class DeleteHospitalEmployee extends HospitalEmployeeEvent {
  final String id;

  DeleteHospitalEmployee(this.id);

  @override
  List<Object> get props => [id];

}

class UpdateHospitalEmployee extends HospitalEmployeeEvent {
  final String id;
  final HospitalEmployee updated;

  UpdateHospitalEmployee(this.id, this.updated);

  @override
  List<Object> get props => [id, updated];
}
