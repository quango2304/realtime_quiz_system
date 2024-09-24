part of 'new_quiz_cubit.dart';

abstract class NewQuizState extends Equatable {
  const NewQuizState();

  @override
  List<Object?> get props => [];
}

class NewQuizInitial extends NewQuizState {}

class NewQuizCreating extends NewQuizState {}

class NewQuizCreateSuccess extends NewQuizState {
  final QuizResponse quiz;

  const NewQuizCreateSuccess(this.quiz);

  @override
  List<Object?> get props => [quiz];
}

class NewQuizCreateFailure extends NewQuizState {
  final String error;

  const NewQuizCreateFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class NewQuizStarting extends NewQuizState {}

class NewQuizStartSuccess extends NewQuizState {}

class NewQuizStartFailure extends NewQuizState {
  final String error;

  const NewQuizStartFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class NewQuizPlayerListUpdated extends NewQuizState {
  final List<String> playerList;

  const NewQuizPlayerListUpdated(this.playerList);

  @override
  List<Object?> get props => [playerList];
}