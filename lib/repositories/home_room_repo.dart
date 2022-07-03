import 'dart:convert';

import 'package:youtobe_demo/models/home_room.dart';
import 'package:flutter/services.dart' as rootBundle;

class HomeRoomRepo{

  Future<List<HomeRoomModel>> getHomeRoom() async {
    final response = await rootBundle.rootBundle.loadString('json/member_family.JSON');
    final list = json.decode(response) as Map<String, dynamic>;
    var obj = list['home_room'].map((e)=> HomeRoomModel.fromJson(e)).toList();
    List<HomeRoomModel> listMember = List<HomeRoomModel>.from(obj);
    return listMember;
  }

}