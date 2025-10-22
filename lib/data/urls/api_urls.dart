class ApiUrls{
  static const String _baseUrl =
      'https://budgetappstudio.com/magicalwalls/public/api';
  static const String getOtp = '$_baseUrl/getCode';
  static const String verifyOtp = '$_baseUrl/verifyCode';
  static const String serviceList = '$_baseUrl/technician/getServices';
  static const String kycComplete = '$_baseUrl/technician/kycVerification';
  static const String kycStatus = '$_baseUrl/technician/kycStatus';
  static const String profileGet = '$_baseUrl/technician/techProfile';
  static const String earningsGet = '$_baseUrl/technician/weeklyEarnings';
  static const String monthlyEarningsGet = '$_baseUrl/technician/monthlyReport';
  static const String locationUpdate = '$_baseUrl/technician/updateLocation';
  static const String getOrderList = '$_baseUrl/technicianHome';
  static const String withDrawRequest = '$_baseUrl/technician/requestWithdrawal';
  static const String updateToggle = '$_baseUrl/technician/availablityUpdate';
  static const String riseSupport = '$_baseUrl/customerSupport';
  static const String profileUpdate = '$_baseUrl/technician/updateTechnician';
  static const String acceptOrder = '$_baseUrl/acceptService';
  static const String startJobSentOtp = '$_baseUrl/technician/startJobOtp';
  static const String verifyStarJobOtp = '$_baseUrl/technician/verifyOtp';
  static const String verifyEndJobOtp = '$_baseUrl/technician/requestCompletionOtp';
  static const String takeSelfieToStartJob = '$_baseUrl/technician/selfie';
  static const String takeSelfieToEndJob = '$_baseUrl/technician/selfie'; // Changes Need
  static const String markAsCompleted = '$_baseUrl/technician/completeWork';
  static const String getNotification = '$_baseUrl/getNotifications';
  static const String getCheckList = '$_baseUrl/getServiceIncludes';

}