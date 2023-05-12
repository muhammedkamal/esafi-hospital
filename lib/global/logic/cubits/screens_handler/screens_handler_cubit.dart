import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screens_handler_state.dart';

class ScreenHandlerCubit extends Cubit<ScreenHandlerState> {
  ScreenHandlerCubit() : super(CurrentScreen(0));

  void changeScreen(int index) {
    emit(CurrentScreen(index));
  }
}
