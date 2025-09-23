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
  static const String locationUpdate = '$_baseUrl/technician/updateLocation';
  static const String getOrderList = '$_baseUrl/technicianHome';
  static const String withDrawRequest = '$_baseUrl/technician/requestWithdrawal';
  static const String updateToggle = '$_baseUrl/technician/availablityUpdate';
  static const String riseSupport = '$_baseUrl/customerSupport';
  static const String profileUpdate = '$_baseUrl/technician/updateTechnician';
}