import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/driver.dart';
import '../provider/driver_provider.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverBloc() : super(DriverInitial()) {
    on<DriverEvent>(
      (event, emit) async {
        try {
          if (event is LoadDriver) {
            emit(DriverLoading());
            List<AmbulanceDriver> driver =
                await DriverProvider().getDriver(event.hospitalId);
            emit(DriverLoaded(driver));
          } else if (event is DeleteDriver) {
            emit(DriverLoading());
            await DriverProvider().deleteDriver(event.hospitalId);
            List<AmbulanceDriver> driver = await DriverProvider().getDriver(event.hospitalId);
            emit(DriverLoaded(driver));
          } else if (event is UpdateDriver) {
            emit(DriverLoading());
            await DriverProvider()
                .updateDriver(event.hospitalId, event.updated.toMap());
            List<AmbulanceDriver> driver = await DriverProvider().getDriver(event.hospitalId);
            emit(DriverLoaded(driver));
          } else if (event is AddDriver) {
            emit(DriverLoading());
            await DriverProvider().createDriver(event.data);
            List<AmbulanceDriver> driver = await DriverProvider().getDriver(event.hospitalId);
            emit(DriverLoaded(driver));
          }
        } catch (e) {
          emit(DriverLoadingError(e.toString()));
        }
      },
    );
  }

  Future<void> createDriver(Map<String, dynamic> data) async {
    await DriverProvider().createDriver(data);
  }
}
