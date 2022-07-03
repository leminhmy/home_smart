import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:youtobe_demo/models/member.dart';
import 'package:youtobe_demo/repositories/member_repo.dart';

import '../../../models/device.dart';
import '../../../models/home_room.dart';
import '../../../models/weather.dart';
import '../../../repositories/home_room_repo.dart';
import '../../../repositories/weather_repo.dart';
import '../../../services/boredService.dart';
import '../../../services/connectivityService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;
  final HomeRoomRepo _homeRoomRepo;
  final MemberRepo _memberRepo;
  final WeatherRepo _weatherRepo;
  HomeBloc(this._boredService,this._connectivityService,this._homeRoomRepo,this._memberRepo, this._weatherRepo) : super(HomeInitial()) {
    _connectivityService.connectitvityStream.stream.listen((event) {
      if(event == ConnectivityResult.none){
        print('No internet');
        add(NoInternetEvent());
      }
      else{
        print('yes Internet');
        add(LoadDataEvent());
      }
    });


    on<LoadDataEvent>((event, emit) async{
      emit(HomeLoadingState());
      await  Future.delayed(Duration(seconds: 2),() async{
        LatLng latLng =  LatLng(10.835886, 106.661597);
        List<MemberModel> listMember = await _memberRepo.getMember();
        List<HomeRoomModel> listHomeRoom = await _homeRoomRepo.getHomeRoom();
        CurrentModel weather = await _weatherRepo.getWeather(latLng.latitude.toString(), latLng.longitude.toString());
        weather.weather![0].icon = 'http://openweathermap.org/img/w/${weather.weather![0].icon}.png';
        emit(HomeLoadedState(listMember: listMember,listHomeRoom: listHomeRoom,currentModel: weather,locationLatLng: latLng,myLocation: "Hồ Chí Minh"));
      });
    });

    on<SetLocationEvent>(_onUpdateLocation);
  }

  void _onUpdateLocation(SetLocationEvent event, Emitter<HomeState> emit) async{
    final state = this.state;
    if(state is HomeLoadedState){
      CurrentModel weather = await _weatherRepo.getWeather(event.locationLatLng.latitude.toString(), event.locationLatLng.longitude.toString());
      weather.weather![0].icon = 'http://openweathermap.org/img/w/${weather.weather![0].icon}.png';
      emit(HomeLoadedState(currentModel: weather,listHomeRoom: List.from(state.listHomeRoom!),listMember: List.from(state.listMember!),locationLatLng: event.locationLatLng,myLocation: event.myLocation));
    }

  }
}
