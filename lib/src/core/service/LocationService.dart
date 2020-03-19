import 'dart:async';

import 'package:location/location.dart';
import 'package:myjob/src/core/model/UserLocation.dart';

class LocationService {
  UserLocation _currentLocation;
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  UserLocation _previousLocation;

  var location = Location();

  LocationService() {
    location.requestPermission().then((grated) {
      if (grated == PermissionStatus.GRANTED) {
        location.onLocationChanged().listen((locationData) {
          if (locationData.longitude != _previousLocation?.longitude &&
              locationData.latitude != _previousLocation?.latitude) {
            final newLocation = UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude);

            _locationController.add(newLocation);
            _previousLocation = newLocation;
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {} on Exception catch (e) {
      print("Could not get location:\n${e.toString()}");
    }

    return _currentLocation;
  }
}
