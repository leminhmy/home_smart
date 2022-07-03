part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable{
  const HomeEvent();
}


class LoadDataEvent extends HomeEvent{


  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class NoInternetEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class SetLocationEvent extends HomeEvent{
  final LatLng locationLatLng;
  final String myLocation;

  const SetLocationEvent({required this.locationLatLng,required this.myLocation});

  @override
  // TODO: implement props
  List<Object?> get props => [locationLatLng,myLocation];

}






