import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as  http;
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());


  static AppCubit get(context)=>BlocProvider.of(context);

  LatLng? currentLocation;
  MapController controller = MapController();


  void getCurrentLocation({required bool hasPermission}){
    emit(GetCurrentLocationLoading());
    if(!hasPermission){
      emit(GetCurrentLocationError());
      return;
    }
    else{
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then(
              (value){
                LatLng newPos = LatLng(value.latitude, value.longitude);
                currentLocation = newPos;
                double zoom = 12.0;
                controller.moveAndRotate(currentLocation!, zoom, 0);
                emit(GetCurrentLocationSuccessfully());
              },
      ).catchError((error){
        emit(GetCurrentLocationError());
      });
    }

  }

  void updateLocation(LatLng point){
    currentLocation = point;
    emit(UpdateLocation());
  }

  void getAddress(){

    var client = http.Client();
    var url = Uri.https(
        'api.bigdatacloud.net',
        '/data/reverse-geocode-client',
        {
          'latitude':currentLocation!.latitude.toString(),
          'longitude':currentLocation!.longitude.toString(),
          'localityLanguage':'en',
        }
        );
    client.get(url).then((value) {
      var decodedResponse = jsonDecode(utf8.decode(value.bodyBytes)) as Map;
      print('${decodedResponse['locality']}');
    }).catchError((error){
      print(error.toString());
    });
  }
}
