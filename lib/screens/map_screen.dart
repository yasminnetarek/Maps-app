import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_itsharks/shared/cubits/app_cubit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if(state is GetCurrentLocationLoading){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: FlutterMap(
            options: MapOptions(
              initialCenter: cubit.currentLocation!,
              onTap: (tapPosition,point){
                cubit.updateLocation(point);
                cubit.getAddress();
              }
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://api.maptiler.com/maps/satellite/{z}/{x}/{y}.jpg?key=WB1imKRisyiBa9agZNux',
                maxZoom: 20,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: cubit.currentLocation!,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 55.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
