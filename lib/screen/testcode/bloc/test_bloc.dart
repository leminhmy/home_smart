

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../home/bloc/home_bloc.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<LoadDataEvent>(_loadedData);

    on<AddStringEvent>(_addStringData);
  }

  _loadedData(LoadDataEvent event, Emitter<TestState> emit){
    List<String> listText= [

    ];
    emit(TestLoaded(listText: listText));
  }

  _addStringData(AddStringEvent event, Emitter<TestState> emit){

    final state = this.state;
    if(state is TestLoaded){

      emit(TestLoaded(listText: List.from(state.listText)..add(event.text)));

    }


  }
}
