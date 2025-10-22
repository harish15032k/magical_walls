import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/location/controller/location_access_controller.dart';

import '../../../widgets/common_search.dart';

class LocationSearchManually extends StatefulWidget {
  const LocationSearchManually({super.key});

  @override
  State<StatefulWidget> createState() => _LocationSearchManuallyState();
}

class _LocationSearchManuallyState extends State<LocationSearchManually> {
  final LocationAccessController controller = LocationAccessController();
  List<String> addressList = [];
  bool isAddressSearching = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                ),
                Text("Enter Your Location", style: CommonTextStyles.medium18),
              ],
            ),
            const SizedBox(height: 12),
            CommonSearch(
              onChanged: (s) async {
                if (s.length > 3) {
                  isAddressSearching = true;
                  setState(() {});
                  addressList.addAll(await controller.searchPlaces(s));
                  isAddressSearching = false;
                  setState(() {});
                } else {
                  addressList.clear();
                  isAddressSearching = false;
                  setState(() {});
                }
              },
              hintText: "Search by area, city or pincode",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Search location", style: CommonTextStyles.medium18),
            ),
            Expanded(
              child: isAddressSearching
                  ? Center(child: CircularProgressIndicator(strokeWidth: 2))
                  : ListView.builder(
                      itemCount: addressList.length ?? 0,
                      itemBuilder: (c, p) {
                        return GestureDetector(
                          onTap: () async {
                            final latLng = await controller
                                .getLatLngFromAddress(addressList[p]);
                            Get.back(
                              result: {
                                'address': addressList[p],
                                'latitude': latLng?.latitude,
                                'longitude': latLng?.longitude,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              spacing: 5,
                              children: [
                                Image.asset(
                                  "assets/images/location.png",
                                  height: 16,
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    addressList[p],
                                    style: CommonTextStyles.regular14,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}
