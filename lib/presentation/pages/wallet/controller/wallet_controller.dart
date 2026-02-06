import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/api_urls.dart';
import 'package:magical_walls/core/utils/utils.dart';
import 'package:magical_walls/presentation/pages/wallet/controller/payment_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../profile/controller/profile_controller.dart';
import '../model/wallet_model.dart';
import '../repository/wallet_repository.dart';
import '../screen/wallet_recharge.dart';

class WalletController extends GetxController
    implements OnPaymentStatusCallback {
  final TextEditingController walletRechargeController =
      TextEditingController();
  final RxString selectedRechargeValue = "0".obs;
  final List<String> walletTransactionFilters = [
    "All",
    "Earning",
    "Spend",
    "Refund",
  ];
  String selectedWalletTransactionFilter = "All";
  final RxBool isWalletTransactionFullScreen = false.obs,
      showWalletBalance = true.obs;
  WalletRepository repository = WalletRepository();
  int currentPage = 0, totalPage = 10;
  WalletModel? walletModel;
  RxString walletBalance = "0".obs;
  PaymentController? paymentController;
  ProfileController profileController = Get.find<ProfileController>();
  ValueNotifier<bool> walletRechargeListener = ValueNotifier(false);

  Future<bool> getWalletData({
    required BuildContext context,
    String? type,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (currentPage <= totalPage) {
      currentPage++;
      final response = await repository.getWalletApiData(
        page: currentPage,
        token: preferences.getString(AppConstants.token) ?? "",
        type: type?.toLowerCase() ?? "all",
      );
      if (response is Map && response['status'] == true) {
        final data = WalletModel.fromJson(response['data']);
        if (walletModel == null) {
          walletModel = data;
          walletBalance.value = walletModel?.wallet?.amount ?? "0";
          totalPage = walletModel?.transactions?.lastPage ?? 1;
        } else {
          walletModel?.wallet = data.wallet;
          walletModel?.transactions?.lastPage = data.transactions?.lastPage;
          walletModel?.transactions?.data ??= [];
          walletModel?.transactions?.data?.addAll(
            data.transactions?.data ?? [],
          );
          walletBalance.value = walletModel?.wallet?.amount ?? "0";
          totalPage = walletModel?.transactions?.lastPage ?? 1;
        }
        return true;
      } else {
        showCustomSnackBar(
          context: context,
          errorMessage: response is Map
              ? response['message'] ?? "Try Again"
              : "Try Again",
        );
      }
    }
    return false;
  }

  void addCustomerWalletPayment({
    required BuildContext context,
    required String amount,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await repository.addCustomerPaymentApi(
      token: preferences.getString(AppConstants.token) ?? "",
      body: {'amount': amount},
    );
    if (response is Map && response['status'] == true && response['data'] is Map) {
      final Map<dynamic, dynamic> data = response['data'] as Map;
      if (data.containsKey(AppConstants.orderId) && paymentController == null) {
        paymentController = PaymentController(
          onPaymentStatusCallback: this,
          amount: (double.tryParse(amount) ?? 0).toInt(),
          orderId: data[AppConstants.orderId],
          email: profileController.profileData.first.email ?? "",
        );
        paymentController?.initPayment();
      }
    } else {
      showCustomSnackBar(
        context: context,
        errorMessage:response is Map ?  response['message'] ?? "Try Again" : "Try Again",
      );
    }
  }

  void moveWalletRecharge() async {
    final data = await Get.to(
      () => WalletRecharge(controller: this),
      transition: Transition.rightToLeft,
    );
    walletRechargeListener.value = !walletRechargeListener.value;
  }

  @override
  void onPaymentFailure(data) {
    paymentController = null;
  }

  @override
  void onPaymentSuccess(data) async {
    paymentController = null;
    selectedRechargeValue.value = "";
    walletRechargeController.text = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (data is Map) {
      if (data['data'] != null) {
        final response = await repository.verifyCustomerPaymentApi(
          token: preferences.getString(AppConstants.token) ?? "",
          body: data['data'],
        );
        if (response is Map && response['status'] == true) {
          walletBalance.value =
              "${(double.tryParse(walletBalance.value) ?? 0) + (double.tryParse("${data['data']['amount']}") ?? 0)}";
          walletModel?.wallet ??= Wallet(amount: "0");
          walletModel?.wallet?.amount = walletBalance.value;
          walletModel?.transactions ??= Transactions();
          walletModel?.transactions?.data ??= [];
          walletModel?.transactions?.data?.insert(
            0,
            Data(
              reason: "Wallet Recharge",
              type: AppConstants.earning,
              amount: "${data['data']['amount']}",
              createdAt: DateTime.now().toUtc().toString(),
            ),
          );
        }
      }
    }
  }
}
