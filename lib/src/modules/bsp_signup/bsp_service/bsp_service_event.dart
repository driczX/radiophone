import 'dart:async';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_repository.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_state.dart';

import 'package:meta/meta.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_repository.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_state.dart';

@immutable
abstract class BspServiceEvent {
  Future<BspServiceState> applyAsync(
      {BspServiceState currentState, BspServiceBloc bloc});
  final BspServiceRepository _bspServiceRepository = new BspServiceRepository();
}

class LoadBspServiceEvent extends BspServiceEvent {
  @override
  String toString() => 'LoadBspServiceEvent';

  @override
  Future<BspServiceState> applyAsync(
      {BspServiceState currentState, BspServiceBloc bloc}) async {
    try {
      BspServices bspList = await this._bspServiceRepository.getBspServices();
      return new InBspServiceState(bspList);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorBspServiceState(_?.toString());
    }
  }
}
