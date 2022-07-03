import 'dart:convert';

import '../models/member.dart';
import 'package:flutter/services.dart' as rootBundle;
class MemberRepo{

  Future<List<MemberModel>> getMember() async {
    final response = await rootBundle.rootBundle.loadString('json/member_family.JSON');
    final list = json.decode(response) as Map<String, dynamic>;
    var obj = list['members'].map((e)=> MemberModel.fromJson(e)).toList();
    List<MemberModel> listMember = List<MemberModel>.from(obj);
    return listMember;
  }

}