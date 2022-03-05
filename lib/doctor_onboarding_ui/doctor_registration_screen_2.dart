import 'dart:async';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:true_care_pharmacy/doctor_onboarding_ui/doctor_registration_screen_1.dart';


import '../app/AppHelper.dart';
import '../app/app_state.dart';
import '../helper/progress_dialog.dart';
import '../network/http_methods.dart';
import '../widgets/WidgetHelper.dart';


// the code below is used to create the OTP verification screen
// of the app
class OTPVerificationScreen extends StatefulWidget {
  // the code below is used to create a property for getting the
  // value of flag to check that if the value is 1 then the
  // user is coming from the login button to the
  // phone number screen and if the value is 0 then the user is
  // coming from the signup screen


  // the property below is used to get the phone number of the
  // user
  final String userPhoneNumber;

  // the property below is used to get the country code
  final String countryCode;

  // the property below is used to get the OTP from the user


  final smsCode;
  final verificationId;

  // initializing the above value using dart constructor
  const OTPVerificationScreen({
    Key? key,
    required this.userPhoneNumber,
    required this.countryCode,
    this.smsCode,
    this.verificationId,
  }) : super(key: key);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends AppState<OTPVerificationScreen> {


  bool disableResendOTPBtn = true;

  int howManyTimesResendOTPPressed = 0;
  final int _resendOTPIntervalTime = 30;
  int currentSeconds = 0;

  final interval = const Duration(seconds: 1);

  TextEditingController otpTextEditingController = TextEditingController();


  String get resendOTPButtonText =>
      '${((_resendOTPIntervalTime - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((_resendOTPIntervalTime - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void startTimer() {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= _resendOTPIntervalTime){
          disableResendOTPBtn = false;
          timer.cancel();
        }
      });
    });
  }

  //TextEditingController otpVerificationTextEditingController = TextEditingController();

  //OTPTextEditController _otpTextEditingController;


  // using the initState() method below
  @override
  void initState() {
    super.initState();

    startTimer();
    setState(() { });

    // the below line of code is for debugging purpose
    print("Inside OTP verification initState method");
    print("The phone number entered by the user is: ${widget.userPhoneNumber}");
    //print("The value of flag is: ${widget.flag}");

    // _otpTextEditingController = OTPTextEditController(
    //   codeLength: 6,
    //   //ignore: avoid_print
    //   onCodeReceive: (code) {
    //     print('Your Application receive code - $code');
    //     VerifyFirebaseOtp(code);
    //   },
    // )..startListenUserConsent(
    //       (code) {
    //     final exp = RegExp(r'(\d{6})');
    //     return exp.stringMatch(code ?? '') ?? '';
    //   },
    //   strategies: [
    //     //SampleStrategy(),
    //   ],
    // );

    // using the send user phone number method here
    // verifyUserOTP(widget.userPhoneNumber.toString());
  }


  Future<void> VerifyFirebaseOtp(String otp) async {
    ProgressDialog.show(context);
    FirebaseAuth _auth = FirebaseAuth.instance;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId,smsCode: otp);
    // Sign the user in (or link) with the credential
    try{
      await _auth.signInWithCredential(credential).then((value){
        ProgressDialog.hide();
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              DoctorRegistrationScreenOne(),
          transitionDuration: const Duration(seconds: 0),
        ));
      });
    }
    catch(error){
      print("Verify OTP Error");
      print(error);
      AppHelper.showSnackBarMessage(error.toString());
    }
    //verifyOtp(widget.userPhoneNumber.toString(), widget.otp.toString());
    //_auth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
            WidgetHelper().TitleTextCustom("Verify Your Phone Number","+91 "+widget.userPhoneNumber),
            Expanded(child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // the code below is used to create a textfield for  getting
                    // the OTP from the user
                    PinCodeTextField(
                      appContext: context,
                      //controller: _otpTextEditingController,
                      keyboardType: TextInputType.number,
                      length: 6,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15.0),
                        borderWidth: 0.2,
                        fieldHeight: 60.0,
                        fieldWidth: 60.0,
                        activeColor: Color(0xFF24224D),
                        inactiveColor: Color(0xFF24224D),
                        errorBorderColor: Colors.red,
                        selectedColor: Color(0xFF24224D),
                      ),
                      cursorColor: const Color(0xFF24224D),
                      onChanged: (String value) {
                        String otp = value;
                        if (otp == null) {
                          AppHelper.showSnackBarMessage("Please enter OTP.");
                        } else if (otp.length != 6) {
                          AppHelper.showSnackBarMessage("Please enter valid OTP.");
                        } else {
                          VerifyFirebaseOtp(otp.toString());
                        }
                        // the below line of code is for debugging purpose
                        print("The OTP entered by the user is: $value");
                        print("The Internal OTP from not Firebase : $otp");
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    // the code below is used to create a button to be used when the OTP
                    // is not recieved to the user
                    Center(
                      child: GestureDetector(
                        onTap: disableResendOTPBtn?null:() {
                          disableResendOTPBtn = true;
                          startTimer();
                          resendCodeAPI(widget.userPhoneNumber.toString());
                        },
                        child: Text(
                            disableResendOTPBtn?'Wait for $resendOTPButtonText':'Code Not Received?',
                            // styling the above text
                            style: TextStyle(color: Colors.black)
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                )
            )),

          ],
        ),
      )
      // the code below is used to add the button for the user to go to the otp screen
    ));
  }

  void verifyOtp(String phoneNumber, String otp) {
    Map<String, String> body = {};
    body["user_phone"] = phoneNumber;
    body["user_otp_code"] = otp;


    /*ApiRequest(
      context: context,
      apiCallBackListener: this,
      showLoader: false,
      httpType: HttpMethods.POST,
      url: ApiUrl.signup,
      apiAction: ApiAction.signup,
      body: body,
    );*/
  }

  void resendCodeAPI(String phoneNumber){
    print("sdlkjslds");
  }

  /*@override
  apiCallBackListener(
      String action, int statusCode, Map<String, dynamic> json) {
    switch (action) {
      case ApiAction.signup:
        {
          SignupModel signupModel = SignupModel.fromJson(json);
          if (statusCode == HttpStatus.ok) {
            AppHelper.showSnackBarMessage(signupModel.message);
            userSession = UserSession.fromJson(signupModel.data.toJson());
            userSession.accessToken = signupModel.accessToken;
            userSession.tokenType = signupModel.tokenType;
            userSession.expiresAt = signupModel.expiresAt;
            if (FirebasePushNotification.instance().firebaseToken != null) {
              userSession.firebaseToken = FirebasePushNotification.instance().firebaseToken;
            }
            //TODO:- REMOVED OLD SESSION
            // AppHelper.saveUserSession(userSession);
            ProgressDialog.hide();
            if (signupModel.data.isRegistered == "N") {
              // the code below is used to go to the email address screen of the app
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                const EmailAddressScreen(),
                transitionDuration: const Duration(seconds: 0),
              ));
            } else if (signupModel.data.isRegistered == "Y") {
              AppHelper.saveUserSession(userSession);
              AppHelper.saveUserFirebase(userSession);
              AppHelper.setIsLifeStyleQuestionAnswered();
              Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) =>
                    const DashboardScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                      (route) => false);
            }
          } else {
            AppHelper.showSnackBarMessage(signupModel.message);
          }
          break;
        }
      case ApiAction.resendOtp:
        {
          ResendOtpModel resendOtpModel = ResendOtpModel.fromJson(json);
          if (statusCode == HttpStatus.ok) {
            AppHelper.showSnackBarMessage(resendOtpModel.message);
            loginUser(widget.countryCode+widget.userPhoneNumber, context,resendOtpModel.data.userOtpCode);
            if (AppConfig.showOtpVerificationCode) {
              //AppHelper.showSnackBarMessage("Please use this OTP in testing mode:- " + resendOtpModel.data.userOtpCode.toString());

            }
          } else {
            AppHelper.showSnackBarMessage(resendOtpModel.message);
          }
          break;
        }
    }
  }

  void resendCodeAPI(String phoneNumber) {
    Map<String, String> body = {};
    body["user_phone"] = phoneNumber;
    body["country_code"] = widget.countryCode;

    *//*ApiRequest(
      context: context,
      apiCallBackListener: this,
      showLoader: true,
      httpType: HttpMethods.POST,
      url: ApiUrl.resendOtp,
      apiAction: ApiAction.resendOtp,
      body: body,
    );*//*
  }*/


  Future<bool?> loginUser(String phone, BuildContext context,int databaseOTP) async{

    //Show Loader Here and Hide Keyboard
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException e) {
          ///do something
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          print("Aapka error");
          print(e.toString());
          ProgressDialog.hide();
          print("Show Dialog here");

          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          //Remove Loader here
          print("Inside Code Sent Hook Event");
          ProgressDialog.hide();
          startTimer();
        },
        codeAutoRetrievalTimeout: (String n){

        }, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  }
    );
  }



  @override
  apiCallBackListener(String action, int statusCode, Map<String, dynamic> json) {
    // TODO: implement apiCallBackListener
    throw UnimplementedError();
  }
}

