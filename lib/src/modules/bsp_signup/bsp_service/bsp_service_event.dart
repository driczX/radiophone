import 'dart:async';
import 'package:tudo/src/modules/bsp_signup/bsp_service/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BspServiceEvent {
  Future<BspServiceState> applyAsync(
      {BspServiceState currentState, BspServiceBloc bloc});
  final BspServiceRepository _bspServiceRepository = new BspServiceRepository();
}

class LoadBspServiceEvent extends BspServiceEvent {
  final int countryId;
  final bool isHome;
  final bool isWalkin;
  final bool isOnDemand;

  LoadBspServiceEvent(
      {this.countryId, this.isHome, this.isWalkin, this.isOnDemand});

  @override
  String toString() => 'LoadBspServiceEvent';

  @override
  Future<BspServiceState> applyAsync(
      {BspServiceState currentState, BspServiceBloc bloc}) async {
    try {
      BspServices bspList = await this
          ._bspServiceRepository
          .getBspServices(countryId, isHome, isWalkin, isOnDemand);
      return new InBspServiceState(bspList);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorBspServiceState(_?.toString());
    }
  }
}
