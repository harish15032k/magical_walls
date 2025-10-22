import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Home/controller/home_controller.dart';
import 'package:magical_walls/presentation/pages/Home/screens/notification_screen.dart';
import 'package:magical_walls/presentation/pages/profile/controller/profile_controller.dart';
import 'package:magical_walls/presentation/widgets/common_box.dart';
import 'package:magical_walls/presentation/widgets/shimmer.dart';

import '../../profile/screens/profile_edit.dart';
import '../model/home_mode.dart';
import '../model/Completed_order_model.dart' as co;
import 'order_viewdetails.dart';

class HomeScreen extends StatefulWidget {
  final int? initialindex;

  const HomeScreen({super.key, this.initialindex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialindex ?? 0;
    profileController.getProfile();
  }

  Widget _buildJobList(List<Datum> jobs, String emptyMessage,String tabName) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return ShimmerWidgets.shimmerBox(count: 4, height: 200);
      }

      if (jobs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/review_icon.png', width: 100),
              const SizedBox(height: 16),
              Text(
                emptyMessage,
                style: CommonTextStyles.medium20.copyWith(
                  color: CommonColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return GestureDetector(
            onTap: () {
              Get.to(
                () => JobDetailsScreen(
                  job: {
                    'id': job.bookingId.toString(),
                    'type': job.serviceType ?? '',
                    'customer': job.customerName ?? '',
                    'date': job.bookingDate?.toString() ?? '',
                    'timeSlot': job.timeSlot?.toString() ?? '',
                    'address': job.address?.address ?? '',
                    'phone': job.customerPhoneNumber ?? '',
                    'duration': job.duration ?? '',
                    'tools': job.toolsRequired ?? [],
                    'service_price': job.servicePrice ?? '',
                    'assigned_technician': job.assignedTechnician ?? '',
                  },
                ),
                transition: Transition.zoom,
              );
            },
            child: Obx(
              () => CommonBox(
                tab: tabName,
                jobId: job.bookingId?.toString() ?? '',
                jobType: job.serviceType ?? '',
                customerName: job.customerName ?? '',
                date: job.bookingDate != null ? job.bookingDate.toString() : '',
                timeSlot: job.timeSlot?.toString() ?? '',
                address: job.address?.address ?? '',
                isLoadingAccept:
                    homeController
                        .loadingAcceptMap[job.bookingId.toString()]
                        ?.value ??
                    false,
                isLoadingReject:
                    homeController
                        .loadingRejectMap[job.bookingId.toString()]
                        ?.value ??
                    false,
                onAccept: () async {
                  homeController.acceptService(
                    job.bookingId,
                    'accept',
                    context,
                    index: index,
                  );

                  await Get.to(
                    () => JobDetailsScreen(
                      job: {
                        'id': job.bookingId.toString(),
                        'type': job.serviceType ?? '',
                        'customer': job.customerName ?? '',
                        'date': job.bookingDate?.toString() ?? '',
                        'timeSlot': job.timeSlot?.toString() ?? '',
                        'address': job.address?.address ?? '',
                        'phone': job.customerPhoneNumber ?? '',
                        'duration': job.duration ?? '',
                        'tools': job.toolsRequired ?? [],
                        'service_price': job.servicePrice ?? '',
                        'assigned_technician': job.assignedTechnician ?? '',
                      },
                      isaccept: true,
                    ),
                    transition: Transition.zoom,
                  );
                },
                onReject: () {
                  homeController.acceptService(
                    job.bookingId,
                    'reject',
                    context,
                    index: index,
                  );
                },
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildJobListCompleted(List<co.Datum> jobs, String emptyMessage,String tabName) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return ShimmerWidgets.shimmerBox(count: 4, height: 200);
      }

      if (jobs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/review_icon.png', width: 100),
              const SizedBox(height: 16),
              Text(
                emptyMessage,
                style: CommonTextStyles.medium20.copyWith(
                  color: CommonColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return GestureDetector(
            onTap: () {
              // Get.to(
              //       () => JobDetailsScreen(job: {
              //     'id': job.bookingId.toString(),
              //     'type': job.serviceType ?? '',
              //     'customer': job.customerName?? '',
              //     'date': job.bookingDate?.toString() ?? '',
              //     'timeSlot': job.timeSlot?.toString() ?? '',
              //     'address': job.address?.address ?? '',
              //   }),
              //   transition: Transition.zoom,
              // );
            },
            child: CommonBox(
              tab: tabName,
              jobId: job.bookingId?.toString() ?? '',
              jobType: job.serviceType ?? '',
              customerName: job.timeSlot ?? '',
              date: job.bookingDate != null ? job.bookingDate.toString() : '',
              timeSlot: job.timeSlot?.toString() ?? '',
              address: job.timeSlot ?? '',
            ),
          );
        },
      );
    });
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
          homeController.getOrderList(title.toLowerCase());
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? CommonColors.primaryColor.withAlpha(25)
              : CommonColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: CommonTextStyles.regular16.copyWith(
            color: isSelected ? CommonColors.primaryColor : CommonColors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            child: Row(
              children: [
                Obx(() {
                  if (profileController.profileData.isEmpty ||
                      profileController.profileData.first.technicianImage == null ||
                      profileController.profileData.first.technicianImage!.isEmpty) {

                    final name = profileController.profileData.isNotEmpty
                        ? profileController.profileData.first.name ?? "?"
                        : "?";
                    return GestureDetector(
                      onTap: (){
                        Get.to(
                              () => ProfileEdit(
                            data: profileController.profileData.first,
                          ),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: CommonColors.grey,
                        child: Text(
                          name.isNotEmpty ? name.substring(0, 1).toUpperCase() : "?",
                          style: CommonTextStyles.medium16.copyWith(
                            color: CommonColors.white,
                          ),
                        ),
                      ),
                    );
                  } else {

                    return GestureDetector(
                      onTap: (){
                        Get.to(
                              () => ProfileEdit(
                            data: profileController.profileData.first,
                          ),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: CommonColors.grey,
                        backgroundImage: NetworkImage(
                          profileController.profileData.first.technicianImage!,
                        ),
                      ),
                    );
                  }
                }),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() {
                    if (profileController.profileData.isEmpty) {
                      return Text(
                        'Hi, !',
                        style: CommonTextStyles.medium16,
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return Text(
                        'Hi, ${profileController.profileData.first.name ?? ''} !',
                        style: CommonTextStyles.medium16,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                          () => NotificationScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Image.asset(
                    'assets/images/notification.png',
                    width: 25,
                  ),
                ),
              ],
            ),

          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
              decoration: BoxDecoration(
                color: CommonColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: CommonColors.textFieldGrey,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab("Upcoming", 0),
                  _buildTab("Ongoing", 1),
                  _buildTab("Completed", 2),
                ],
              ),
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: [
                _buildJobList(
                  homeController.upcomingOrders,
                  "No upcoming jobs yet",
                  'upcoming'
                ),
                _buildJobList(
                  homeController.ongoingOrders,
                  "No ongoing jobs yet",'ongoing'
                ),
                _buildJobListCompleted(
                  homeController.completedOrders,
                  "No completed jobs yet",'completed'
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
