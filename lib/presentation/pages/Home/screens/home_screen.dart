import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Home/controller/home_controller.dart';
import 'package:magical_walls/presentation/pages/Home/screens/notification_screen.dart';
import 'package:magical_walls/presentation/widgets/common_box.dart';
import 'package:magical_walls/presentation/widgets/shimmer.dart';

import '../../../widgets/common_button.dart';
import '../model/home_mode.dart';
import 'order_viewdetails.dart';

class HomeScreen extends StatefulWidget {
  final int? initialindex;

  const HomeScreen({super.key, this.initialindex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialindex ?? 0;


  }

  Widget _buildJobList(List<Datum> jobs, String emptyMessage) {
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
                    () => JobDetailsScreen(job: {
                  'id': job.id.toString(),
                  'type': job.service?.name ?? '',
                  'customer': job.user?.name ?? '',
                  'date': job.startDate?.toString() ?? '',
                  'timeSlot': job.timeSlot?.toString() ?? '',
                  'address': job.address?.addressLine1 ?? '',
                }),
                transition: Transition.zoom,
              );
            },
            child: CommonBox(
              tab: emptyMessage,
              jobId: job.id?.toString() ?? '',
              jobType: job.service?.name ?? '',
              customerName: job.user?.name ?? '',
              date: job.startDate != null
                  ? "${job.startDate!.day}-${job.startDate!.month}-${job.startDate!.year}"
                  : '',
              timeSlot: job.timeSlot?.toString() ?? '',
              address: job.address?.addressLine1 ?? '',
              onAccept: () => Get.to(
                    () => JobDetailsScreen(
                  job: {
                    'id': job.id.toString(),
                    'type': job.service?.name ?? '',
                    'customer': job.user?.name ?? '',
                    'date': job.startDate?.toString() ?? '',
                    'timeSlot': job.timeSlot?.toString() ?? '',
                    'address': job.address?.addressLine1 ?? '',
                  },
                  isaccept: true,
                ),
                transition: Transition.zoom,
              ),
              onReject: () => debugPrint("Rejected: ${job.id}"),
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
                CircleAvatar(
                  radius: 15,
                  backgroundColor: CommonColors.grey,
                  child: Text(
                    'H',
                    style: CommonTextStyles.medium16.copyWith(
                      color: CommonColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showNewServiceRequestPopup(context);
                  },
                  child: Text('Hi, Ramesh!', style: CommonTextStyles.medium16),
                ),
                const Spacer(),
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
                _buildJobList(homeController.upcomingOrders, "No upcoming jobs yet"),
                _buildJobList(homeController.ongoingOrders, "No ongoing jobs yet"),
                _buildJobList(homeController.completedOrders, "No completed jobs yet"),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void showNewServiceRequestPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.only(left: 16, right: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CommonColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CommonColors.textFieldGrey,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Service Request',
                        style: CommonTextStyles.medium22),
                    const SizedBox(height: 3),
                    Text(
                      'You will got a new job nearby.',
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      color: CommonColors.purple.withAlpha(30),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '#df45cxw2',
                          style: CommonTextStyles.regular12.copyWith(
                            color: CommonColors.purple,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'AC Repair - Gas Refill',
                      style: CommonTextStyles.medium18.copyWith(
                        color: CommonColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer',
                                style: CommonTextStyles.regular14.copyWith(
                                  color: CommonColors.secondary,
                                )),
                            Text('Ravi Kumar',
                                style: CommonTextStyles.medium14),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date',
                                style: CommonTextStyles.regular14.copyWith(
                                  color: CommonColors.secondary,
                                )),
                            Text('25 July 2025',
                                style: CommonTextStyles.medium14),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time Slot',
                                style: CommonTextStyles.regular14.copyWith(
                                  color: CommonColors.secondary,
                                )),
                            Text('10 AM – 12 PM',
                                style: CommonTextStyles.regular14),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const SizedBox(height: 8),
                    Text('Address',
                        style: CommonTextStyles.regular14.copyWith(
                          color: CommonColors.secondary,
                        )),
                    const SizedBox(height: 4),
                    Text("Flat 202, Lotus Apartments, Chennai",
                        style: CommonTextStyles.medium14),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CommonButton(
                            onTap: () {
                              Get.back();
                            },
                            text: 'Reject',
                            backgroundColor: Colors.transparent,
                            textColor: CommonColors.purple,
                            borderColor: CommonColors.purple,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CommonButton(
                            backgroundColor: CommonColors.primaryColor,
                            textColor: CommonColors.white,
                            text: 'Accept',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                width: 20,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset('assets/images/close-circle.png'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
