class CurrentModel{
 double? temp;
 int? humidity;
 List<WeatherModel>? weather;


 CurrentModel.fromJson(Map<dynamic, dynamic> json){
   temp = json['temp'];
   humidity = json['humidity'];
   if (json['weather'] != null) {
     weather = <WeatherModel>[];
     json['weather'].forEach((v) {
       weather!.add(WeatherModel.fromJson(v));
     });
   }
 }

 Map<String, dynamic> toJson() {
   return {
     "id": this.temp,
     "name": this.humidity,
     "weather": this.weather,

   };
 }
}

class WeatherModel{
  String? description;
  String? icon;

  WeatherModel.fromJson(Map<String, dynamic> json){
    description = json['description'];
    icon = json['icon'];

  }

  Map<String, dynamic> toJson() {
    return {
      "description": this.description,
      "icon": this.icon,

    };
  }
}
