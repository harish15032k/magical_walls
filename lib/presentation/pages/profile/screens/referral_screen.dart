
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/presentation/widgets/common_no_data_found.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/utils/utils.dart';
import '../controller/profile_controller.dart';
import '../model/referral_history_model.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  ProfileController controller = Get.put(ProfileController());


  @override
  void initState() {
    controller.isLoading.value = false;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await controller.getReferral(context);
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Referral", style: CommonTextStyles.medium20),
                ],
              ),

              Container(
                margin: const EdgeInsets.only(top: 18, bottom: 14),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/ic_referral_earning_bg.png",
                    ),
                  ),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Image.asset('assets/images/ic_referral_cup.png',width: 60,height: 60,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          "Your Earnings",
                          style: CommonTextStyles.regular18,
                        ),
                        Text(
                          "₹ ${controller.referralModel?.referralEarnings ??
                              "0"}",
                          style: CommonTextStyles.bold18.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "Invite Friends & Earn Rewards",
                style: CommonTextStyles.medium18,
              ),
              const SizedBox(height: 8),
              Text(
                "Share your referral code to earn rewards.",
                style: CommonTextStyles.regular14,
              ),
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CommonColors.textFieldGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 11,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Referral Code: ",
                              style: CommonTextStyles.regular14,
                            ),
                            Expanded(child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal, child: Text(
                                controller.referralCode,
                                style: CommonTextStyles.medium16),),),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(onTap: () async {
                      try {
                        await FlutterClipboard.copy(controller.referralCode);
                      }  catch (e) {
                        showCustomSnackBar(
                            context: context, errorMessage: "Try Again");
                      }
                    }, child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: CommonColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        "copy",
                        style: CommonTextStyles.regular14.copyWith(
                          color: CommonColors.white,
                        ),
                      ),
                    ),),
                  ],
                ),
              ),
              Row(
                spacing: 20,
                children: [
                  GestureDetector(onTap: () async {
                    debugPrint("referralShareLink 1");
                  //  await controller.showShareAppBottomSheet(context);
                    try {
                      final Uri url = Uri.parse(
                        "https://wa.me/?text=${controller.referralShareLink}",
                      );
                      debugPrint("referralShareLink 2");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode
                            .externalApplication);
                        debugPrint("referralShareLink 3");
                      } else {
                        debugPrint("referralShareLink 4");
                        showCustomSnackBar(
                            context: context, errorMessage: "Whatsapp Not found");
                        SharePlus.instance.share(
                            ShareParams(text: controller.referralShareLink)
                        );
                      }
                      debugPrint("referralShareLink 5");
                    }catch(e){
                      debugPrint("referralShareLink catch $e");
                      showCustomSnackBar(
                          context: context, errorMessage: "Whatsapp Not found");
                    }
                  },child:   Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 9,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: CommonColors.primaryColor),
                    ),
                    child: Row(
                      spacing: 5,
                      children: [
                        Image.asset('assets/images/ic_whatapp.png',width: 24,height: 24,),
                        Text(
                          "Share via whatsapp",
                          style: CommonTextStyles.medium12.copyWith(
                            color: CommonColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),),
                  Expanded(
                    child: GestureDetector(onTap: () {
                     // controller.showShareAppBottomSheet(context);

                    }, child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: CommonColors.primaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Image.asset('assets/images/ic_referral_share.png',width: 24,height: 24,),
                          Text(
                            "Share Link",
                            style: CommonTextStyles.medium12.copyWith(
                              color: CommonColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: CommonColors.textFieldGrey),
                      left: BorderSide(color: CommonColors.textFieldGrey),
                      right: BorderSide(color: CommonColors.textFieldGrey),
                      bottom: BorderSide.none,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 24),
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "Referral Activity",
                          style: CommonTextStyles.regular18,
                        ),
                      ),
                      Expanded(
                        child: controller.isLoading.value ? Center(
                          child: CircularProgressIndicator(strokeWidth: 1,
                            color: CommonColors.primaryColor,),) : controller.referralModel?.referralHistory?.isNotEmpty == true ? ListView
                            .separated(
                          itemCount: controller.referralModel?.referralHistory?.length ?? 0,
                          itemBuilder: (c, p) {
                            ReferralHistoryModel? ref = controller.referralModel
                                ?.referralHistory?[p];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              child: Row(
                                spacing: 8,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CommonColors.primaryColor
                                          .withAlpha(10),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      ref?.referredProfileImage ?? "",
                                      fit: BoxFit.cover,
                                      loadingBuilder: (c, w, p) {
                                        if (p == null) {
                                          return w;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder: (c, e, st) {
                                        return Image.asset(
                                          'assets/images/profile.png',
                                          height: 35,
                                          width: 35,color: CommonColors.grey,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(spacing: 2,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ref?.referredName ?? "User",
                                          style: CommonTextStyles.regular16,
                                        ),
                                        Text(
                                          "Joined using your referral",
                                          style: CommonTextStyles.regular14
                                              .copyWith(
                                            color: CommonColors.secondary,
                                          ),),
                                        Text(
                                          Utils
                                              .convertDateAndTimeFromUtcTime(
                                              ref?.createdAt ??
                                                  ref?.updatedAt ??
                                                  DateTime
                                                      .now()
                                                      .toUtc()
                                                      .toString()),
                                          style: CommonTextStyles.regular14
                                              .copyWith(
                                            color: CommonColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "+ ₹${Utils.doubleValueConversation(
                                        ref?.amount ?? "0")}",
                                    style: CommonTextStyles.bold18.copyWith(
                                      color: CommonColors.coolGreen,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (c, p) {
                            return Divider(color: CommonColors.textFieldGrey);
                          },
                        ) : CommonNoDataFound(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
