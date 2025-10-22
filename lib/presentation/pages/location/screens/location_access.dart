import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../widgets/common_button.dart';
import '../controller/location_access_controller.dart';
import 'location_search_manually.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  final controller = LocationAccessController();

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 100,
            left: 0,
            right: 0,
            child: GoogleMap(
              myLocationButtonEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.hybrid,
              initialCameraPosition: controller.kGooglePlex,
              onMapCreated: (GoogleMapController c) {
                controller.mapController = c;
              },
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/map_marker.png",
              height: 15,
              width: 15,
            ),
          ),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child:  Obx(
            () => Visibility(
              visible: controller.isLoading.value,
              child: Center(
                child: CircularProgressIndicator(
                  color: CommonColors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
          ),),
        ],
      ),
    ),
    bottomSheet: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: CommonColors.white,
      child: Column(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Find services near you", style: CommonTextStyles.medium18),
          Text(
            "We use your location to show local services and \n estimated timing.",
            style: CommonTextStyles.regular12?.copyWith(
              color: CommonColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          CommonButton(
            isLoading: controller.isLoading.value,
            onTap: () => controller.checkLocationPermissionAndGPS(context),
            text: "Use my current location",
            backgroundColor: CommonColors.primaryColor,
            textColor: CommonColors.white,
          ),
          const SizedBox(height: 5),
          CommonButton(
            text: "Enter location manually",
            textColor: CommonColors.purple,
            borderColor: CommonColors.purple,
            onTap: () {
              Get.to(
                () => LocationSearchManually(),
                transition: Transition.downToUp,
              );
            },
          ),
        ],
      ),
    ),
  );
}
