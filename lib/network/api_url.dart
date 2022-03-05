class ApiUrl {
  static const String hostUrl = "https://www.markitiers.in/";
  static const String apiUrl = hostUrl + "codee/";
  static const String postImageUrl = apiUrl + "storage/post/";
  static const String login = apiUrl + "api/auth/login";
  static const String checkfieldexist = apiUrl + "public/api/checkfieldexist";
  static const String otpVerify = apiUrl + "public/api/auth/signup";
  static const String resendOtp = apiUrl + "public/api/auth/resend/otp";
  static const String gender = apiUrl + "public/api/get/gender";
  static const String uploadImage = apiUrl + "public/api/uploadimage";
  static const String agoraToken = apiUrl + "public/api/auth/agora/token";
  static const String signup = apiUrl + "public/api/auth/signup";
  static const String profileFeed = apiUrl + "public/api/auth/match/profile";
  static const String connection = apiUrl + "public/api/auth/connection?status=ACEPT";
  static const String pendingConnection = apiUrl + "public/api/auth/connection?status=PENDING";
  static const String connectionRequest = apiUrl + "public/api/auth/accept/connection/request";

  static const String connectionRequestSend = apiUrl + "public/api/auth/send/connection/request";
  static const String connectionRequestIgnore = apiUrl + "public/api/auth/ignore/connection/request";
  static const String profile = apiUrl + "public/api/get/profile";
  static const String updateProfile = apiUrl + "public/api/auth/update/profile";
  static const String addEducation = apiUrl + "public/api/auth/add/education";
  static const String question = apiUrl + "public/api/get/question";
  static const String questionCategory = apiUrl + "public/api/get/question/category";
  static const String answer = apiUrl + "public/api/auth/user/ans";
  static const String feedback = apiUrl + "public/api/auth/feedback";
  static const String categoryList = apiUrl + "public/api/auth/solve/question";
  static const String forumPost = apiUrl + "public/api/auth/forum/post";
  static const String forumInterest = apiUrl + "public/api/auth/view/interest/forum";
  static const String likePost = apiUrl + "public/api/auth/forum/post/like";
  static const String savePost = apiUrl + "public/api/auth/forum/post/save";
  static const String hidePost = apiUrl + "public/api/auth/hide/forum/post";
  static const String social = apiUrl + "public/api/auth/check/social";

  static const String subscriptionPlans = apiUrl + "public/api/get/plan";
  static const String subscription = apiUrl + "public/api/auth/subscription";

  static const String deleteprofile = apiUrl + "public/api/auth/delete/account";

  static const String hideReport = apiUrl + "public/api/auth/report/user";

  static const String allQuestion = apiUrl + "public/api/get/question";

  static const String meetMeAt = apiUrl + "public/api/auth/get/meet/me/at";


}
