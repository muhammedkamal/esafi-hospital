part of 'screens_handler_cubit.dart';

@immutable
abstract class ScreenHandlerState {
  final int currentIndex;

  ScreenHandlerState(this.currentIndex);
}

class CurrentScreen extends ScreenHandlerState {
  CurrentScreen(int currentIndex) : super(currentIndex);
}
