class ApiAction {
  static const String login = "login";
  static const String signup = "public/api/auth/signup";
  static const String checkfieldexist = "checkfieldexist";
  static const String otpVerify = "otpVerify";
  static const String resendOtp = "/auth/resend/otp";
  static const String gender = "public/api/get/gender";
  static const String uploadImage = "public/api/uploadimage";
  static const String agoraToken = "public/api/auth/agora/token";
  static const String profileFeed = "public/api/auth/match/profile";
  static const String connection = "public/api/auth/connection?status=ACEPT";
  static const String pendingConnection = "public/api/auth/connection?status=PENDING";
  static const String connectionRequest = "public/api/auth/accept/connection/request";
  static const String profile = "public/api/get/profile";
  static const String connectionRequestSend = "public/api/auth/send/connection/request";
  static const String connectionRequestIgnore = "public/api/auth/ignore/connection/request";
  static const String updateProfile = "public/api/auth/update/profile";
  static const String addEducation = "public/api/auth/add/education";
  static const String questionCategory = "public/api/get/question/category";
  static const String question = "public/api/get/question";
  static const String answer = "public/api/auth/user/ans";
  static const String feedback = "public/api/auth/feedback";
  static const String categoryList = "public/api/auth/solve/question";
  static const String forumPost = "public/api/auth/forum/post";
  static const String forumInterest = "public/api/auth/view/interest/forum";
  static const String likePost = "public/api/auth/forum/post/like";
  static const String savePost = "public/api/auth/forum/post/save";
  static const String hidePost = "public/api/auth/hide/forum/post";
  static const String social = "public/api/auth/check/social";
  static const String subscription = "public/api/auth/subscription";
  static const String subscriptionPlans = "public/api/get/plan";
  static const String deleteProfile = "public/api/auth/delete/account";
  static const String hideReport = "public/api/auth/report/user";
  static const String allQuestion = "public/api/get/question";
  static const String meetMeAt = "/public/api/auth/get/meet/me/at";

}
