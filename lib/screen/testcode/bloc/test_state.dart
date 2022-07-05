part of 'test_bloc.dart';

@immutable
abstract class TestState extends Equatable{}

class TestInitial extends TestState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TestLoaded extends TestState {
  final List<String> listText;

  TestLoaded({ required this.listText});

  @override
  // TODO: implement props
  List<Object?> get props => [listText];
}
