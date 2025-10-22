import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_text.dart';
import '../../../widgets/common_search.dart';


class LocationSearchManually extends StatefulWidget {
  const LocationSearchManually({super.key});

  @override
  State<StatefulWidget> createState() => _LocationSearchManuallyState();
}

class _LocationSearchManuallyState extends State<LocationSearchManually> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
              onChanged: (s) {},
              hintText: "Search by area, city or pincode",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Popular location", style: CommonTextStyles.medium18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (c, p) {
                  return Padding(
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
                            "Anna Nagar, Chennai",
                            style: CommonTextStyles.regular14,
                          ),
                        ),
                      ],
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
