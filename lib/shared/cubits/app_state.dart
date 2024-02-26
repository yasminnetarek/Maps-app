part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetCurrentLocationLoading extends AppState{}
class GetCurrentLocationSuccessfully extends AppState{}
class GetCurrentLocationError extends AppState{}
class UpdateLocation extends AppState{}