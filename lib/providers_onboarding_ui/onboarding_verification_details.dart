import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:true_care_pharmacy/helper/globals.dart';
import 'package:true_care_pharmacy/main.dart';
import 'package:true_care_pharmacy/widgets/WidgetHelper.dart';

import '../app/app_state.dart';
import '../app_localizations.dart';
import '../helper/progress_dialog.dart';
import '../widgets/CustomMultiSelectDropDown.dart';
import 'onboarding_otp_screen.dart';
import 'onboarding_last_step_screen.dart';

class OnboardingVerificationDetailsScreen extends StatefulWidget {
  @override
  _OnboardingVerificationDetailsScreenState createState() => _OnboardingVerificationDetailsScreenState();
}

class _OnboardingVerificationDetailsScreenState extends AppState<OnboardingVerificationDetailsScreen> {
  TextEditingController drNameTextEditingController = TextEditingController();
  TextEditingController specialityTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController = TextEditingController();
  TextEditingController emailAddressTextEditingController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verifyID = "";

  String specialityOfDoctor="";







  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: kIsWeb?CrossAxisAlignment.center:CrossAxisAlignment.start,
            children: [
              WidgetHelper().TitleTextCustom("verify_yourself","using_phone_or_gmail",context),
              //SizedBox(height: size.height*0.52,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.2,
                child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_6e0qqtpa.json',)
              ),
              Container(
                width:kIsWeb?size.width*0.2:size.width*0.9,
                child: WidgetHelper().CustomTextField("mobile_no"," +91 | ",null,"mobile_no",phoneNumberTextEditingController,context),
              ),
              SizedBox(height: size.height*0.019,),
              Container(
                width:kIsWeb?size.width*0.2:size.width*0.9,
                child: WidgetHelper().CustomTextField("email_id"," ",null,"email_id",emailAddressTextEditingController,context),
              ),
              SizedBox(height: 10,),

              SizedBox(height: 20,),
              SizedBox(
                width: kIsWeb?size.width*0.2:size.width*0.9,
                height: size.height*0.08,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: primaryColorOfApp
                      ),
                      onPressed: () {
                        print("+91"+phoneNumberTextEditingController.text);
                        phoneSignIn("+91"+phoneNumberTextEditingController.text);
                      },
                      child: Text('Proceed',style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 24,fontWeight: FontWeight.w600),
                      ),)),
                ),
              ),
              SizedBox(height: 10,),
              Center(child: Text(
                'or',
                style: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: 20,fontWeight: FontWeight.w600),
              ),),
              SizedBox(height: 10,),
              SizedBox(
                width: kIsWeb?size.width*0.2:size.width*0.9,
                height: size.height*0.08,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: primaryColorOfApp
                      ),
                      onPressed: () {
                        userProviderSession.name = drNameTextEditingController.text;
                        userProviderSession.speciality = specialityOfDoctor;
                        userProviderSession.phoneNumber = phoneNumberTextEditingController.text;
                        userProviderSession.emailId = emailAddressTextEditingController.text;

                        Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation,
                                  Animation<double> secondaryAnimation) =>
                                  OnBoardingLastStepScreen(),
                              transitionDuration: const Duration(seconds: 0),
                            ),);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continue with Google',style: GoogleFonts.roboto(
                              textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w600),
                            ),),
                            SizedBox(width: 10,),
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: secondaryColorOfApp,
                              child: IconButton(
                                  onPressed: null,
                                  icon: Icon(FontAwesomeIcons.google,size: 24,color: Colors.white,)),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        )
      )
    ));
  }


  Future<void> phoneSignIn(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      print("Verification Completed");
      //this.otpTextEditingController.text = authCredential.smsCode;
    });
    if (authCredential.smsCode != null) {
      try{
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        //isLoading = false;
      });
      Navigator.pushNamed(context,'Home');
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      print("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    //this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    print(verificationId);
    verifyID = verificationId;
    ProgressDialog.hide();

    print("Inside Code Sent Hook Event");
    ProgressDialog.hide();

    userProviderSession.name = drNameTextEditingController.text;
    userProviderSession.speciality = specialityOfDoctor;
    userProviderSession.phoneNumber = phoneNumberTextEditingController.text;
    userProviderSession.emailId = emailAddressTextEditingController.text;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
            OTPVerificationScreen(
              userPhoneNumber: phoneNumberTextEditingController.text.toString(),
              countryCode: "+91",
              verificationId:verificationId,
            ),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  _onCodeTimeout(String timeout) {
    return null;
  }


}

