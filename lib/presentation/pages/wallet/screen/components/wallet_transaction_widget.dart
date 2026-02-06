import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/presentation/widgets/common_no_data_found.dart';

import '../../../../../core/constants/api_urls.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text.dart';
import '../../../../../core/utils/utils.dart';
import '../../controller/wallet_controller.dart';
import '../../model/wallet_model.dart';

class WalletTransactionWidget extends StatefulWidget {
  final WalletController controller;

  const WalletTransactionWidget({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _WalletTransactionWidgetState();
}

class _WalletTransactionWidgetState extends State<WalletTransactionWidget> {
  late WalletController controller;
  List<Data> transactionList = [];
  final ScrollController scrollController = ScrollController();
  bool isPaginationLoading = false;
  @override
  void initState() {
    controller = widget.controller;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
  //   onClickFilters(controller.selectedWalletTransactionFilter);
      setUpTransactionData();
    });

    controller.walletRechargeListener.addListener(onWalletRechargeCallBack);

    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        debugPrint("_WalletTransactionWidgetState  ${scrollController.position
            .pixels}");
        isPaginationLoading = true;
        setState(() {

        });
        final data = await controller.getWalletData(context: context,type: controller.selectedWalletTransactionFilter);
        isPaginationLoading = false;
        setState(() {

        });
        if (data == true) {
          setUpTransactionData();
        }

      }
    });
  }


  void onWalletRechargeCallBack() async{
   await Future.delayed(const Duration(seconds: 3),(){
     setUpTransactionData();
   });
  }

  void setUpTransactionData() async {
    transactionList.clear();
    if (controller.walletModel?.transactions?.data?.isNotEmpty == true) {
      if (controller.selectedWalletTransactionFilter.toUpperCase() == "ALL") {
        transactionList.addAll(
            controller.walletModel?.transactions?.data ?? []);
      } else {
        transactionList.addAll(
            controller.walletModel?.transactions?.data?.where((it) =>
            it.type
                ?.toUpperCase() ==
                controller.selectedWalletTransactionFilter.toUpperCase()) ??
                []);
      }
    }
    setState(() {

    });
  }

  void onClickFilters(String filter) async{
    controller.walletModel = null;
    controller.currentPage = 0;
    setState(() {

    });
    final data = await controller.getWalletData(context: context,type: controller.selectedWalletTransactionFilter);
    setUpTransactionData();
  }

  @override
  void dispose() {
    controller.walletRechargeListener.addListener(onWalletRechargeCallBack);
    scrollController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction History", style: CommonTextStyles.medium16),
            Obx(() =>
                GestureDetector(
              onTap: () {
                controller.isWalletTransactionFullScreen.value =
                    !controller.isWalletTransactionFullScreen.value;
              },
                  child: Text(
                controller.isWalletTransactionFullScreen.value
                    ? "Hide"
                    : "See All",
                style: CommonTextStyles.medium14.copyWith(
                  color: CommonColors.primaryColor,
                ),
              ),
                ),),
          ],
        ),

        SizedBox(
          height: 30,//MediaQuery.of(context).size.height * 0.04,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.walletTransactionFilters.length,
            itemBuilder: (c, p) {

              final filter = controller.walletTransactionFilters[p];
              bool isSelected =
                  filter.toUpperCase() ==
                  controller.selectedWalletTransactionFilter.toUpperCase();
              return GestureDetector(
                onTap: () async {
                  controller.selectedWalletTransactionFilter = filter;
                  onClickFilters(controller.selectedWalletTransactionFilter);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: CommonColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        )
                      : BoxDecoration(
                          border: Border.all(color: CommonColors.textFieldGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: Text(
                    filter,
                    style: CommonTextStyles.medium16.copyWith(
                      color: isSelected
                          ? CommonColors.white
                          : CommonColors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(child: transactionList.isNotEmpty ?
        ListView.separated(padding: const EdgeInsets.only(bottom: 30),
          controller: scrollController,
          itemCount: isPaginationLoading
              ? transactionList.length + 1
              : transactionList.length,
          itemBuilder: (c, p) {
            if (isPaginationLoading == true &&
                p == transactionList.length) {
              return Padding(padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: CircularProgressIndicator(
                    strokeWidth: 1, color: CommonColors.primaryColor,),));
            }
            final Data data = transactionList[p];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.reason ?? "",
                          style: CommonTextStyles.regular14,
                        ),
                        Text(
                          Utils.convertDateAndTimeFromUtcTime(data.createdAt ??
                              data.updatedAt ?? "",
                              format: "d MMMM y, hh:mm a"),
                          style: CommonTextStyles.regular12.copyWith(
                            color: CommonColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    " ${data.type?.toUpperCase() == AppConstants.spend.toUpperCase() ? '-' : '+'} ₹${data.amount ?? ""}",
                    style: CommonTextStyles.regular14.copyWith(
                      color: data.type?.toUpperCase() ==
                          AppConstants.spend.toUpperCase()
                          ? CommonColors.vividRed : CommonColors.limeGreen,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (c, p) {
            return Divider(thickness: 0.5,);
          },
        ) : Center(child: CommonNoDataFound()),),
      ],
    );
  }
}
