import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/utils/utils.dart';
import '../../Home/screens/bottom_bar.dart';
import '../repository/location_repository.dart';

class LocationAccessController extends GetxController {
  GoogleMapController? mapController;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(11.0560888, 76.9513379),
    zoom: 10.5,
  );
  LatLng? currentLatLng;
  String? currentLocation;
  late LocationRepository repository;
  RxBool isLoading = false.obs;
  SharedPreferences? preferences;

  @override
  void onInit() async {
    preferences = await SharedPreferences.getInstance();
    repository = LocationRepository();
    super.onInit();
  }

  void checkLocationPermissionAndGPS(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    debugPrint("checkLocationPermissionAndGPS -> $permission");
    if (context.mounted == true) {
      if (!serviceEnabled) {
        await _showGpsDialog(context);
      } else if (permission == LocationPermission.denied) {
        final r = await Geolocator.requestPermission();
        if (r == LocationPermission.always ||
            r == LocationPermission.whileInUse) {
          isLoading.value = true;
          final position =
              await Geolocator.getLastKnownPosition() ??
              await Geolocator.getCurrentPosition();
          currentLatLng = LatLng(position.latitude, position.longitude);
          if (mapController != null) {
            mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14.0,
                ),
              ),
            );
          }
          await getAddress(position.latitude, position.longitude);
          await updateLocationApi(
            position: LatLng(position.latitude, position.longitude),
            context: context,
          );
          isLoading.value = false;
        } else if (r == LocationPermission.denied) {
          showCustomSnackBar(
            context: context,
            errorMessage:
                "Location Permission is denied permanently to enable location permission in app settings",
          );
        }
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        isLoading.value = true;
        final position = await Geolocator.getCurrentPosition();
        currentLatLng = LatLng(position.latitude, position.longitude);

        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 14.0,
              ),
            ),
          );
        }
        await getAddress(position.latitude, position.longitude);
        await updateLocationApi(
          position: LatLng(position.latitude, position.longitude),
          context: context,
        );
        isLoading.value = false;
      } else if (permission == LocationPermission.deniedForever) {
        showCustomSnackBar(
          context: context,
          errorMessage:
              "Location Permission is denied permanently to enable location permission in app settings",
        );
      } else {
        showCustomSnackBar(
          context: context,
          errorMessage: "Enable Location Permission to access your location",
        );
      }
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
              await Geolocator.openLocationSettings(); // Opens device GPS settings
            },
            child: Text(
              "Open Settings",
              style: CommonTextStyles.bold16.copyWith(
                color: CommonColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<String>> searchPlaces(String input) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:in&radius=3000&key=${AppConstants.MAP_KEY}";

    final response = await http.get(Uri.parse(url));
    debugPrint("searchPlaces  ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data["predictions"] as List;
      return predictions.map((p) => p["description"] as String).toList();
    } else {
      throw Exception("Failed to load places");
    }
  }

  Future<void> getAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      Placemark place = placemarks[0];
      currentLocation =
          " ${place.street ?? place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      debugPrint("currentLocation $currentLocation");
    } catch (e) {
      debugPrint("currentLocation $e");
    }
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        return LatLng(latitude, longitude);
      } else {
        debugPrint("No location found for this address.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  Future<void> updateLocationApi({
    required LatLng position,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    final data = await repository
        .updateUserLocationApi(preferences?.getString('token') ?? "", {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'address': currentLocation,
        });
    showCustomSnackBar(context: context, errorMessage: data.message ?? "");
    if (data.status == true) {
      preferences?.setBool("locationUpdated", true);
      Get.offAll(() => BottomBar(), transition: Transition.rightToLeft);
    }
    isLoading.value = false;
  }
}
