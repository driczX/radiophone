import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/index.dart';

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
