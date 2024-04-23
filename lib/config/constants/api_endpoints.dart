class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Windows
  static const String baseUrl = "http://10.0.2.2:5500/api/";
  // static const String baseUrl = "http://192.168.1.66:5000/api/";
  // For MAC
  // static const String baseUrl = "http://localhost:3000/api/v1/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  static const limitPage = 4;
  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String updateUsers = "user/updateUser/";
  static const String forgetPassword = "user/forgetpassword";
  static const String verifyOtp = "user/verifyOtp";
  static const String resetPassword = "user/resetPassword";
  static const String changePassword = "user/changepassword";
  // ============================ user Routes ======================
  static const String updateUsersDetils = "userdetails/updateUserdata";
  // ====================== jobs Routes ======================
  static const String getAllJobs = "jobs/getjobsWithoutSaved/";
  static const String getAllRecommendedJobs = "jobs/recommendations/";

  static const String getFavorite = "saved/likedjobs";
  static const String getFavoriteJobs = "saved/likedjobs/";
  static const String postApplication = "application/apply";
  static const String getApplication = "application/getApplicationByUserId/";

  // comment
  static const String postComment = "comment/create";
  static const String getComment = "comment/getComment/";
}
