

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:magical_walls/presentation/pages/location/model/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/utils/utils.dart';
import '../../Home/screens/bottom_bar.dart';
import '../repository/location_repository.dart';
class LocationAccessController extends GetxController {
  var isLoading = false.obs;
  GoogleMapController? mapController;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(11.0005324, 76.7359868),
    zoom: 14.4746,
  );

  CameraPosition kLake = const CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(11.0005324, 76.7359868),
    tilt: 59.440717697143555,
    zoom: 20.15,
  );

  Location location = Location();
  LatLng? currentLatLng;
  LocationRepository repo = LocationRepository();

  Future<void> checkLocationPermissionAndGPS(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token == null) {
      showCustomSnackBar(
        context: context,
        errorMessage: "User token not found. Please login again.",
      );
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    debugPrint("checkLocationPermissionAndGPS -> $permission");

    if (!context.mounted) return;

    if (!serviceEnabled) {
      await _showGpsDialog(context);
      return;
    }

    if (permission == LocationPermission.denied) {
      final r = await Geolocator.requestPermission();
      if (r != LocationPermission.always && r != LocationPermission.whileInUse) {
        showCustomSnackBar(
          context: context,
          errorMessage:
          "Location permission is denied. Please enable in settings.",
        );
        return;
      }
    } else if (permission == LocationPermission.deniedForever) {
      showCustomSnackBar(
        context: context,
        errorMessage:
        "Location Permission is denied permanently. Please enable it in app settings.",
      );
      return;
    }

    await _updateLocationAndCallApi(context, token);
  }

  Future<void> _updateLocationAndCallApi(
      BuildContext context, String token) async {
    try {
      isLoading.value = true;

      final position = await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition();

      currentLatLng = LatLng(position.latitude, position.longitude);

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLatLng!,
              zoom: 14.0,
            ),
          ),
        );
      }

      final map = {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };

      LocationRes data = await repo.updateUserLocationApi(token, map);
      if(data.status==true){
        SharedPreferences prefs =await SharedPreferences.getInstance();
        prefs.setBool('locationUpdated', true);

        showCustomSnackBar(
          context: context,
          errorMessage: data.message ?? "Location updated successfully",
        );

        Get.to(() => BottomBar(), transition: Transition.rightToLeft);

      }

    } catch (e) {
      showCustomSnackBar(
        context: context,
        errorMessage: "Failed to update location: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _showGpsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Enable GPS", style: CommonTextStyles.bold18),
        content: Text(
          "GPS is required for this app. Please enable location services.",
          style: CommonTextStyles.medium14,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
            },
            child: Text(
              "Open Settings",
              style: CommonTextStyles.bold16?.copyWith(
                color: CommonColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

