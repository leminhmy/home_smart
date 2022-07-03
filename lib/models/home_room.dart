import 'device.dart';

class HomeRoomModel{
  String? id;
  String? name;
  String? image;
  List<DeviceModel>? device;

  HomeRoomModel({
    this.id,
    this.name,
    this.image,
    this.device,
  });

  HomeRoomModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    image = json['image'];
    if (json['device'] != null) {
      device = <DeviceModel>[];
      json['device'].forEach((v) {
        device!.add(DeviceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "image": this.image,
      "device":this.device,

    };
  }
}