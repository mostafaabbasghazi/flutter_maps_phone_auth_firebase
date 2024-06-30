import 'package:geolocator/geolocator.dart';

class LocationHelper{
  static Future<Position> getCurntLocation()async{
    bool isServiceEnable=await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnable){
      await Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }
}