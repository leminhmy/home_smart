part of 'test_bloc.dart';

@immutable
abstract class TestEvent extends Equatable{
  const TestEvent();
}


class LoadDataEvent extends TestEvent{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddStringEvent extends TestEvent{
  final String text;

  const AddStringEvent({required this.text});

  @override
  // TODO: implement props
  List<Object?> get props => [text];

}