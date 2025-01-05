part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final List<User> users;
  const UserSuccess(this.users);
}

final class UserFailUre extends UserState {
  final String message;
  const UserFailUre(this.message);
}
