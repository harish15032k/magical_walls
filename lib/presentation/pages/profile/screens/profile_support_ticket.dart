import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/profile/screens/profile_suppport.dart';
import 'package:magical_walls/presentation/widgets/common_no_data_found.dart';
import '../../../../core/constants/api_urls.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/utils/utils.dart';
import '../controller/profile_controller.dart';
import '../model/support_tickets_model.dart';

class ProfileSupportTicket extends StatefulWidget {

  const ProfileSupportTicket({super.key});

  @override
  State createState() => _ProfileSupportTicketState();
}

class _ProfileSupportTicketState extends State<ProfileSupportTicket> {
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      if (controller.supportModel.isEmpty) {
        await controller.getTechnicianSupportList(context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Help & Support", style: CommonTextStyles.medium20),
                ],
              ),
              Obx(() =>
              controller.isHideSupportTicket.value ? Container(
                padding: const EdgeInsets.only(left: 13, top: 10, bottom: 10),
                margin: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: CommonColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                  color: CommonColors.mistyRose,
                ),
                child: Row(
                  spacing: 25,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          "Need Help?",
                          style: CommonTextStyles.semiBold16.copyWith(
                            color: CommonColors.primaryColor,
                          ),
                        ),
                        Text(
                          "Submit a ticket to get \n assistance!",
                          style: CommonTextStyles.medium14,
                        ),

                        GestureDetector(
                          onTap: () async {
                            await Get.to(
                              () => HelpAndSupportScreen(),
                              transition: Transition.downToUp,
                            );
                            setState(() {

                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: CommonColors.primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                Icon(Icons.add, color: CommonColors.white),
                                Text(
                                  "Create New Ticket",
                                  style: CommonTextStyles.regular14.copyWith(
                                    color: CommonColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Image.asset('assets/images/ic_create_support.png'),
                    ),
                  ],
                ),
              ) : const SizedBox(height: 24,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Tickets", style: CommonTextStyles.semiBold18),
                  GestureDetector(
                    onTap: () async {
                      controller.isHideSupportTicket.value =
                      !controller.isHideSupportTicket.value;
                    },
                    child: Obx(() =>
                        Text(
                          controller.isHideSupportTicket.value
                              ? "View All"
                              : "Hide",
                      style: CommonTextStyles.regular16.copyWith(
                        color: CommonColors.primaryColor,
                      ),
                        ),
                    ),),
                ],
              ),
              const SizedBox(height: 12),
              Obx(() =>
                  Expanded(
                    child: controller.isCustomerSupportListLoading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: CommonColors.primaryColor,),)
                        : controller.supportModel.isEmpty
                        ? CommonNoDataFound()
                        : ListView.builder(
                      itemCount: controller.supportModel.length,
                  itemBuilder: (c, p) {
                    final SupportModel data = controller.supportModel[p];
                    return Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.monthYear,
                          style: CommonTextStyles.regular14.copyWith(
                            color: CommonColors.placeholderText,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.supportTickets.length,
                          itemBuilder: (cc, pp) {
                            final SupportTicketsModel s = data
                                .supportTickets[pp];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: CommonColors.grey95),
                              ),
                              child: Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Text(
                                          s.subject ?? "",
                                          style: CommonTextStyles.medium16,
                                        ),
                                        Text(s.message ??"",
                                          style: CommonTextStyles.medium14,),
                                        Row(
                                          children: [
                                            Text(
                                              "Ticket #${s.id} ",
                                              style: CommonTextStyles.regular14,
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: CommonColors.midGrey,
                                              ),
                                              height: 8,
                                              width: 8,
                                            ),
                                            Text(
                                              Utils
                                                  .formatDateTimeInHoursDifference(
                                                  s.createdAt ?? s.updatedAt ??
                                                      DateTime
                                                          .now()
                                                          .toUtc()
                                                          .toString()),
                                              style: CommonTextStyles.regular14
                                                  .copyWith(
                                                    color: CommonColors.midGrey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                        color: s.status?.toUpperCase() ==
                                            AppConstants.closed.toUpperCase()
                                            ? CommonColors.mutedGreen
                                            : CommonColors.goldenAmer
                                    ),
                                    child: Text(
                                      s.status?.toUpperCase() ==
                                          AppConstants.inprogress.toUpperCase()
                                          ? "In Progress" : s.status
                                          ?.toUpperCase() ?? "",
                                      style: CommonTextStyles.regular14
                                          .copyWith(color: CommonColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8,)
                      ],
                    );
                  },
                ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }

}
