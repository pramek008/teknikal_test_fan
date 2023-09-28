part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);

  @override
  List<Object?> get props => [message];
}
