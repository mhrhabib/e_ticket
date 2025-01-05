import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashSuccess extends SplashState {
  const SplashSuccess();
}

class SplashFailure extends SplashState {
  final String errorMessage;

  const SplashFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
