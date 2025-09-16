class ApiUrls{
  static const String _baseUrl =
      'https://budgetappstudio.com/magicalwalls/public/api';
  static const String getOtp = '$_baseUrl/getCode';
  static const String verifyOtp = '$_baseUrl/verifyCode';
  static const String serviceList = '$_baseUrl/technician/getServices';
  static const String kycComplete = '$_baseUrl/technician/kycVerification';
  static const String kycStatus = '$_baseUrl/technician/kycStatus';
}