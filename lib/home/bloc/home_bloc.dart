import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../services/boredService.dart';
import '../../services/connectivityService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final BoredService _boredService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._boredService, this._connectivityService) : super(HomeLoadingState()) {

   _connectivityService.connectitvityStream.stream.listen((event) {
      if(event == ConnectivityResult.none){
        print('No internet');
        add(NoInternetEvent());
      }
      else{
        print('yes Internet');
        add(LoadApiEvent());
      }
   });

   on<LoadApiEvent>((event, emit) async {
     emit(HomeLoadingState());
    final activity = await _boredService.getBoredActivity();
    emit(HomeLoadedState(activity.activity, activity.type, activity.participants));

   });

   on<NoInternetEvent>((event, state){
     emit(HomeNoInternetState());
   });

  }
}
