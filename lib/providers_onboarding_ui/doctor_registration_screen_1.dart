import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:true_care_pharmacy/helper/globals.dart';
import 'package:true_care_pharmacy/main.dart';
import 'package:true_care_pharmacy/widgets/WidgetHelper.dart';

import '../app/app_state.dart';
import '../helper/progress_dialog.dart';
import '../widgets/CustomMultiSelectDropDown.dart';
import 'doctor_registration_screen_2.dart';
import 'doctor_registration_screen_3.dart';

class DoctorRegistrationScreenOne extends StatefulWidget {
  @override
  _DoctorRegistrationScreenOneState createState() => _DoctorRegistrationScreenOneState();
}

class _DoctorRegistrationScreenOneState extends AppState<DoctorRegistrationScreenOne> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetHelper().TitleTextCustom("Welcome","doctor",context),
              SizedBox(height: 20,),
              WidgetHelper().CustomTextField("Your Name","Dr. ",null,"Your Good Name",drNameTextEditingController),
              SizedBox(height: 10,),
              Padding(padding:EdgeInsets.all(8) ,child: Text("Your Speciality",style: GoogleFonts.roboto(
                textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w600),
              )),),
              CustomMultiselectDropDown(listOFStrings: ["Psychologist","Sexologist","Gynocologist"],selectedList: (listOfStrings){
                specialityOfDoctor = listOfStrings.join(', ');
              },),
              SizedBox(height: 10,),
              WidgetHelper().CustomTextField("Mobile Number","+91 | ",null,"Your Mobile Number",phoneNumberTextEditingController),
              SizedBox(height: 10,),
              WidgetHelper().CustomTextField("Email Address",null,null,"somemail@email.com",emailAddressTextEditingController),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
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
                width: double.infinity,
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
                        docSession.name = drNameTextEditingController.text;
                        docSession.speciality = specialityOfDoctor;
                        docSession.phoneNumber = phoneNumberTextEditingController.text;
                        docSession.emailId = emailAddressTextEditingController.text;

                        Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation,
                                  Animation<double> secondaryAnimation) =>
                                  RegistrationScreen3(),
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

    docSession.name = drNameTextEditingController.text;
    docSession.speciality = specialityOfDoctor;
    docSession.phoneNumber = phoneNumberTextEditingController.text;
    docSession.emailId = emailAddressTextEditingController.text;

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

