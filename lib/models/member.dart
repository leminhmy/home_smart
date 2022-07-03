class MemberModel{
  String? id;
  String? name;
  String? image;

  MemberModel({
    this.id,
    this.name,
    this.image,
});

  MemberModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "image": this.image,

    };
  }

}