// import 'package:flutter_bloc/flutter_bloc.dart';

// class HospitalEmployeeBloc extends Bloc<HospitalEmployeeEvent, HospitalEmployeeState> {
//   HospitalEmployeeBloc() : super( HospitalEmployeeInitial()) {
//     on<HospitalEmployeeEvent>(
//       (event, emit) async {
//         try {
//           if (event is LoadHospitalEmployee) {
//             emit(HospitalEmployeeLoading());
//            HospitalEmployee hospitalemployee =
//                 await HospitalsProvider().getHospital();
//             emit(HospitalEmployeeLoaded(hospitalemployee));
//             } else if (event is DeleteHospitalEmployee) {
//             emit(HospitalEmployeeLoading());
//             await HospitalsProvider().deleteHospital(event.id);
//             List<HospitalEmployee> hospitalemployee = await HospitalsProvider().getHospital();
//             emit(HospitalEmployeeLoaded(hospitalemployee));
//           } else if (event is UpdateHospitalEmployee) {
//             emit(HospitalEmployeeLoading());
//             await HospitalsProvider().updateHospital(event.id, event.updated.toMap());
//             List<HospitalEmployee> hospitalemployee = await HospitalsProvider().getHospital();
//             emit(HospitalEmployeeLoaded(hospitalemployee));
//           }
//         } catch (e) {
//           emit(HospitalEmployeeLoadingError(e.toString()));
//         }
//       },
//     );
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global/data/models/hospitals.dart';
import '../../../global/logic/providers/hospital_provider.dart';
import '../provider/hospital-employee-provider.dart';
import 'hospital-employe-event.dart';
import 'hospital-employe-state.dart';

class HospitalEmployeeBloc extends Bloc<HospitalEmployeeEvent, HospitalEmployeeState> {
  HospitalEmployeeBloc() : super(HospitalEmployeeInitial()) {
    on<HospitalEmployeeEvent>(
      (event, emit) async {
        try {
          if (event is LoadHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            List<HospitalEmployee> hospitalemployee =
                await HospitalEmployeeProvider().getHospitalEmployee();
            emit(HospitalEmployeeLoaded(hospitalemployee));
            } else if (event is DeleteHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            await HospitalEmployeeProvider().deletehospitalemployee(event.id);
            List<HospitalEmployee> hospitalemployee = await HospitalEmployeeProvider().getHospitalEmployee();
            emit(HospitalEmployeeLoaded(hospitalemployee));
          } else if (event is UpdateHospitalEmployee) {
            emit(HospitalEmployeeLoading());
            await HospitalEmployeeProvider().updatehospitalemployee(event.id, event.updated.toMap());
            List<HospitalEmployee> hospitalemployee = await HospitalEmployeeProvider().getHospitalEmployee();
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
