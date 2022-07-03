import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:youtobe_demo/screen/home/bloc/home_bloc.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key, this.locationLatlng}) : super(key: key);

  final LatLng? locationLatlng;

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
  CameraPosition(target: LatLng(10.835886, 106.661597), zoom: 14);

  Set<Marker> markers = {};
  late LatLng locationLatLng;
  String _currentAddress = "null";



  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  void _initLocation() async{
    if(widget.locationLatlng == null){
      Position initPosition = await Geolocator.getCurrentPosition();
      locationLatLng = LatLng(initPosition.latitude,initPosition.longitude);
    }else{
      locationLatLng = widget.locationLatlng!;

    }
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: locationLatLng));
    setState((){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User current location"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined,color: Colors.white,),
          onPressed: (){
            BlocProvider.of<HomeBloc>(context)
                .add(SetLocationEvent(locationLatLng: locationLatLng,myLocation: _currentAddress));
            Navigator.pop(context);

          },
        ),
        centerTitle: true,

      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onCameraMove: (CameraPosition newPosition) async{
              locationLatLng = newPosition.target;

            },
          ),

         const Center(
              child: Icon(Icons.location_pin,color: Colors.blue,size: 35,))

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            LatLng position = await _determinePosition(locationLatLng);
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(
                  position.latitude,position.longitude
                ),zoom: 14)));

            markers.clear();
            markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(
              position.latitude,position.longitude
            )));
            await _getAddressFromLatLng();
            setState((){

            });
          },
          label: Text("New Location"),
          icon: Icon(Icons.edit_location_outlined)),
    );
  }

  Future<LatLng> _determinePosition(LatLng position) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }


    return position;
  }

  Future<String> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationLatLng.latitude,
          locationLatLng.longitude
      );

      Placemark place = placemarks[0];

      return _currentAddress = "${place.subAdministrativeArea}";

    } catch (e) {
      return _currentAddress = "Error";
    }

  }

}

