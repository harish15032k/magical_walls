import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController {
  final Razorpay _razorpay = Razorpay();
  final OnPaymentStatusCallback onPaymentStatusCallback;
  final int amount;
  final String orderId, phoneNumber, userName, email;
  PaymentController({
    required this.onPaymentStatusCallback,
    required this.amount, required this.orderId
    , this.phoneNumber = "", this.userName = "", this.email = ""
  });

  void initPayment() {
    if(amount > 0) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      _openCheckout();
    }else{
      onPaymentStatusCallback.onPaymentFailure({'message': "Invalid Payment amount"});
    }
  }

  void dispose() {
    _razorpay.clear();
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_RpR7ieCrSWVKHP',
      'amount': amount * 100,
      'name': 'MagicWalls User',
      'order_id': orderId,
      'description'
          : 'Payment',
      'prefill': {'contact': phoneNumber, 'email': email},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      onPaymentStatusCallback.onPaymentFailure({
        'message': "Something Went Wrong,Try Again",
      });
      debugPrint("Payment_Check $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("✅ Payment_Check Successfully: ${response.paymentId}");
    onPaymentStatusCallback.onPaymentSuccess({
      'message':  "Payment successfully completed",
      'data': {
        'razorpay_order_id': response.orderId,
        'razorpay_payment_id': response.paymentId,
        'razorpay_signature': response.signature,
        'amount': amount
      },
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("❌ Payment_Check Failed: ${response.message}");
    onPaymentStatusCallback.onPaymentFailure({'message' : response.message});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint(
      "💰Payment_Check External Wallet Selected: ${response.walletName}",
    );
  }
}

abstract class OnPaymentStatusCallback {
  void onPaymentSuccess(dynamic data);

  void onPaymentFailure(dynamic data);
}
