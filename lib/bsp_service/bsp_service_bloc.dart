import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:testing/bsp_service/bsp_service_event.dart';
import 'package:testing/bsp_service/bsp_service_state.dart';

class BspServiceBloc extends Bloc<BspServiceEvent, BspServiceState> {
  static final BspServiceBloc _bspServiceBlocSingleton =
      new BspServiceBloc._internal();
  factory BspServiceBloc() {
    return _bspServiceBlocSingleton;
  }
  BspServiceBloc._internal();

  BspServiceState get initialState => new UnBspServiceState();

  @override
  Stream<BspServiceState> mapEventToState(
    BspServiceEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}
