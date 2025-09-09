import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Home/screens/notification_screen.dart';
import 'package:magical_walls/presentation/widgets/common_box.dart';
import '../../../widgets/common_button.dart';
import 'order_viewdetails.dart';

class HomeScreen extends StatefulWidget {
final int? initialindex ;

  const HomeScreen({super.key,this.initialindex });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialindex!;
  }
  int selectedTab = 0;

  final List<Map<String, String?>> jobs = [
    {
      'id': 'BK234523',
      'type': 'AC Repair - Gas Refill',
      'customer': 'Ravi Kumar',
      'date': '25 July 2025',
      'timeSlot': '10 AM - 12 PM',
      'address': 'Flat 202, Lotus Apartments, Salem',
    },
  ];

  Widget _buildJobList(String tab) {
    if (jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/review_icon.png',
              width: 100,
            ),
            const SizedBox(height: 16),
            Text(
              'No upcoming jobs yet',
              style: CommonTextStyles.medium20.copyWith(
                color: CommonColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'You’ll see your accepted jobs here.\nHang tight—we’ll notify you when something comes up.',
              style: CommonTextStyles.regular14.copyWith(
                color: CommonColors.grey,
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
            Get.to(()=>JobDetailsScreen(job:job),transition: Transition.zoom);
          },
          child: CommonBox(
            tab: tab,

            jobId: job['id'] ?? '',
            jobType: job['type'] ?? '',
            customerName: job['customer'] ?? '',
            date: job['date'] ?? '',
            timeSlot: job['timeSlot'] ?? '',
            address: job['address'] ?? '',
            onAccept: () =>Get.to(()=>JobDetailsScreen(job:job,isaccept:true),transition: Transition.zoom),
            onReject: () => debugPrint("Rejected: ${job['id']}"),
          ),
        );
      },
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? CommonColors.primaryColor.withAlpha(25) : CommonColors.white,
        borderRadius: BorderRadius.circular(6)
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
                  child: Text('H',
                      style: CommonTextStyles.medium16
                          .copyWith(color: CommonColors.white)),
                ),
                const SizedBox(width: 8),
                GestureDetector(onTap: (){
                  showNewServiceRequestPopup(context);
                }, child: Text('Hi, Ramesh!', style: CommonTextStyles.medium16)),
                Spacer(),
                GestureDetector(onTap: (){
                  Get.to(()=> NotificationScreen(),transition: Transition.rightToLeft);
                }, child: Image.asset('assets/images/notification.png',width: 25,))
              ],
            ),
          ),
          // 🔹 Custom Tab Buttons (like your screenshot)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.fromLTRB(12,6,12,6),
              decoration: BoxDecoration(
                color: CommonColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CommonColors.textFieldGrey,width: 1.5),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab("Upcoming", 0),
                  const SizedBox(width: 12),
                  _buildTab("Ongoing", 1),
                  const SizedBox(width: 12),
                  _buildTab("Completed", 2),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: [
                _buildJobList("upcoming"),
                _buildJobList("ongoing"),
                _buildJobList("completed"),
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
          insetPadding: EdgeInsets.only(left: 16,right: 16),
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
                  border: Border.all(color: CommonColors.textFieldGrey, width: 1.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Service Request',style: CommonTextStyles.medium22,),
                    SizedBox(height: 3,),
                    Text('You will got a new job nearby.',style: CommonTextStyles.regular14.copyWith(color: CommonColors.secondary),),
                    SizedBox(height: 5,),
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
                            Text(
                              'Customer',
                              style: CommonTextStyles.regular14.copyWith(
                                color: CommonColors.secondary,
                              ),
                            ),
                            Text('Ravi Kumar', style: CommonTextStyles.medium14),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: CommonTextStyles.regular14.copyWith(
                                color: CommonColors.secondary,
                              ),
                            ),
                            Text('25 July 2025', style: CommonTextStyles.medium14),
                          ],
                        ),
              
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Slot',
                              style: CommonTextStyles.regular14.copyWith(
                                color: CommonColors.secondary,
                              ),
                            ),
                            Text('10 AM – 12 PM', style: CommonTextStyles.regular14),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
              
                    const SizedBox(height: 8),
                    Text(
                      'Address',
                      style: CommonTextStyles.regular14.copyWith(
                        color: CommonColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("Flat 202, Lotus Apartments, Chennai", style: CommonTextStyles.medium14),
                    const SizedBox(height: 12),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CommonButton(
                            onTap: (){
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
              Positioned(top: 8,right: 8,width: 20, child: InkWell(onTap: (){
                Get.back();
              }, child: Image.asset('assets/images/close-circle.png')),)
            ],
          ),
        );
      },
    );
  }
}
