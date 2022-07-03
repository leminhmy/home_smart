part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable{}

class HomeInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class HomeLoadedState extends HomeState{

  final List<MemberModel>? listMember;
  final List<HomeRoomModel>? listHomeRoom;
  final LatLng? locationLatLng;
  final CurrentModel? currentModel;
  final String? myLocation;
  HomeLoadedState({ this.listMember,  this.listHomeRoom, this.locationLatLng, this.currentModel, this.myLocation});

  @override
  // TODO: implement props
  List<Object?> get props => [listMember,listHomeRoom,locationLatLng,currentModel];

}



