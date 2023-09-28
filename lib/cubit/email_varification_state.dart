part of 'email_varification_cubit.dart';

@immutable
sealed class EmailVarificationState extends Equatable {}

final class EmailVarificationInitial extends EmailVarificationState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EmailVerificationLoading extends EmailVarificationState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EmailVerificationSent extends EmailVarificationState {
  final String message;

  EmailVerificationSent(this.message);

  @override
  List<Object?> get props => [message];
}

class EmailVerificationFailed extends EmailVarificationState {
  final String message;

  EmailVerificationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class EmailVerificationSuccess extends EmailVarificationState {
  final String message;

  EmailVerificationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
