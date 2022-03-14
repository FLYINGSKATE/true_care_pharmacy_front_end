import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:true_care_pharmacy/main.dart';
import 'package:true_care_pharmacy/providers_onboarding_ui/onboarding_last_step_screen.dart';

import '../app_localizations.dart';
import '../helper/globals.dart';
import '../widgets/CustomMultiSelectDropDown.dart';
import '../widgets/WidgetHelper.dart';
import 'onboarding_verification_details.dart';

class AboutScreenOnboarding extends StatefulWidget {

  @override
  _AboutScreenOnboardingState createState() => _AboutScreenOnboardingState();
}

class _AboutScreenOnboardingState extends State<AboutScreenOnboarding> with TickerProviderStateMixin {

  late final AnimationController _controller;
  double opacity = 1.0;

  TextEditingController nameTextEditingController  = TextEditingController();
  TextEditingController specialityTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();

  String specialityOfDoctor="";

  String? dateErrorText;




  @override
  void initState() {
    super.initState();
    changeOpacity();
    _controller = AnimationController(vsync: this);
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
        changeOpacity();
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: kIsWeb?CrossAxisAlignment.center:CrossAxisAlignment.start,
                children: [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 1),
                    child: WidgetHelper().TitleTextCustom(userProviderSession.typeOfProvider == AppLocalizations.of(context)!.translate("doctor")?"tell_us_about":"we_need_details",userProviderSession.typeOfProvider == AppLocalizations.of(context)!.translate("doctor")?"doctor":"hospital_details",context),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.2,
                    child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_6e0qqtpa.json',
                      /*controller: _controller,
                        onLoaded: (composition) {
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },*/
                    ),
                  ),
                ],
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height*0.52,),
                      Container(
                        width:kIsWeb?size.width*0.2:size.width*0.9,
                        child: WidgetHelper().CustomTextField(userProviderSession.typeOfProvider==AppLocalizations.of(context)!.translate("doctor")?"your_name":"your_hospital_name",userProviderSession.typeOfProvider==AppLocalizations.of(context)!.translate("doctor")?" Dr. | ":"",null,userProviderSession.typeOfProvider==AppLocalizations.of(context)!.translate("doctor")?"your_name":"your_hospital_name",nameTextEditingController,context),
                      ),
                      Visibility(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding:EdgeInsets.only(top: size.height*0.02,left: size.height*0.002) ,child: Text("Your Speciality",style: GoogleFonts.roboto(
                            textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w600),
                          )),),
                          Container(
                            width:kIsWeb?size.width*0.2:size.width*0.9,
                            child: CustomMultiselectDropDown(listOFStrings: ["Psychologist","Sexologist","Gynocologist"],selectedList: (listOfStrings){
                              specialityOfDoctor = listOfStrings.join(', ');
                            },),
                          )
                        ],
                      ),visible: userProviderSession.typeOfProvider==AppLocalizations.of(context)!.translate("doctor"),),
                      SizedBox(height: size.height*0.019,),
                      Container(
                        width:kIsWeb?size.width*0.2:size.width*0.9,
                        child:WidgetHelper().CustomDatePickerTextField(userProviderSession.typeOfProvider==AppLocalizations.of(context)!.translate("doctor")?"dob":"doi", "", dateErrorText, "date_hint", dobTextEditingController, context)
                      ),
                      SizedBox(height: size.height*0.019,),
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
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (BuildContext context, Animation<double> animation,
                                        Animation<double> secondaryAnimation) =>
                                        OnboardingVerificationDetailsScreen(),
                                    transitionDuration: const Duration(seconds: 0),
                                  ),);
                              },
                              child: Text('Proceed',style: GoogleFonts.roboto(
                                textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: kIsWeb?size.width*0.025:size.width*0.07,fontWeight: FontWeight.w600),
                              ),)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    ));
  }
}
