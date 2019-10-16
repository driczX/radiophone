
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_model.dart';

@immutable
abstract class BspServiceState extends Equatable {
  final Iterable propss;
  BspServiceState([this.propss]);

  /// Copy object for use in action
  BspServiceState getStateCopy();

  @override
  List<Object> get props => [propss];
}

/// UnInitialized
class UnBspServiceState extends BspServiceState {
  @override
  String toString() => 'UnBspServiceState';

  @override
  BspServiceState getStateCopy() {
    return UnBspServiceState();
  }
}

/// Initialized
class InBspServiceState extends BspServiceState {
  final BspServices bspServices;
  @override
  String toString() => 'InBspServiceState';
  InBspServiceState(this.bspServices);

  @override
  BspServiceState getStateCopy() {
    return InBspServiceState(this.bspServices);
  }
}

class ErrorBspServiceState extends BspServiceState {
  final String errorMessage;

  ErrorBspServiceState(this.errorMessage);

  @override
  String toString() => 'ErrorBspServiceState';

  @override
  BspServiceState getStateCopy() {
    return ErrorBspServiceState(this.errorMessage);
  }
}
