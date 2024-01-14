import 'package:equatable/equatable.dart';

class HandlerLocation extends Equatable {
  const HandlerLocation({
    required this.tokenFcm,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
  final String? tokenFcm;

  factory HandlerLocation.fromJson(Map<String, dynamic> json) {
    return HandlerLocation(
      tokenFcm: json['tokenFcm'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'tokenFcm': tokenFcm,
      'latitude': latitude, 
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props => [tokenFcm, latitude, longitude];
}
