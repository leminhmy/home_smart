class DeviceModel{
  String? id;
  String? name;
  String? image;
  String? temp;
  String? status;

  DeviceModel({
    this.id,
    this.name,
    this.image,
    this.temp,
    this.status,
  });

  DeviceModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    temp = json['temp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "image": this.image,

    };
  }
}
