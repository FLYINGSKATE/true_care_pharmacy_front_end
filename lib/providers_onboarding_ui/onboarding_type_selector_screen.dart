import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
//import 'package:flutter_tts/flutter_tts.dart';
import 'package:true_care_pharmacy/providers_onboarding_ui/onboarding_about_screen.dart';
import '../app_localizations.dart';
import '../helper/globals.dart';
import '../main.dart';
import '../widgets/WidgetHelper.dart';
import 'onboarding_last_step_screen.dart';

class SelectTypeOfProScreen extends StatefulWidget {
  @override
  _SelectTypeOfProScreenState createState() => _SelectTypeOfProScreenState();
}

class _SelectTypeOfProScreenState extends State<SelectTypeOfProScreen> with TickerProviderStateMixin {


  /*late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;*/

  bool showSelectTypeOfProviderErrorText = false;

  bool showSelectGenderErrorText = false;

  /*get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;*/

  late final AnimationController _controller;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    //initTts();
    Future.delayed(Duration.zero,() {
      _localizeList(context);
    });
    changeOpacity();
    _controller = AnimationController(vsync: this);
  }

  // List of items in our dropdown menu
  var genderList = [
    'Select Your Gender',
    'Male',
    'Female',
    'Other',
  ];

  var providerList = [
    'Select Type of Provider',
    'Hospital',
    'Doctor',
  ];

  // Initial Selected Value
  String genderDropdownvalue = 'Select Your Gender';
  String providerDropdownvalue = 'Select Type of Provider';


  void _localizeList(BuildContext context) {
    genderDropdownvalue = AppLocalizations.of(context)!.translate("select_gender");
    providerDropdownvalue =  AppLocalizations.of(context)!.translate("select_provider");
    genderList = [
      AppLocalizations.of(context)!.translate("select_gender"),
      AppLocalizations.of(context)!.translate("male"),
      AppLocalizations.of(context)!.translate("female"),
      AppLocalizations.of(context)!.translate("other"),
    ];
    providerList = [
      AppLocalizations.of(context)!.translate("select_provider"),
      AppLocalizations.of(context)!.translate("hospital"),
      AppLocalizations.of(context)!.translate("doctor"),
    ];
    setState(() {

    });
  }



  /*initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }*/

  /*Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }*/

  @override
  void dispose() {
    super.dispose();
    //flutterTts.stop();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
        changeOpacity();
      });
    });
  }


  /*speakHeading(){
    _newVoiceText =  AppLocalizations.of(context)!.translate("Welcome");
    _speak();
    if(ttsState == TtsState.stopped){
      _newVoiceText = AppLocalizations.of(context)!.translate("how_define");
      _speak();
    }

  }*/




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: kIsWeb?MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: kIsWeb?CrossAxisAlignment.center:CrossAxisAlignment.start,
                  children: [
                    Visibility(child: Align(
                      alignment: Alignment.topRight,
                      child: AnimatedOpacity(opacity: opacity, duration: Duration(seconds: 1),child:TextButton(
                        onPressed: (){
                          existingUserLogin = true;
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation,
                                  Animation<double> secondaryAnimation) =>
                                  OnBoardingLastStepScreen(),
                              transitionDuration: const Duration(seconds: 0),
                            ),);
                        },
                        child:Text(
                          AppLocalizations.of(context)!.translate("login"),
                          style:GoogleFonts.roboto(
                            textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?MediaQuery.of(context).size.width*0.02:MediaQuery.of(context).size.width*0.04),
                          )
                      ),),),
                    ),visible: kIsWeb,),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(seconds: 1),
                      child: WidgetHelper().TitleTextCustom("Welcome","how_define",context),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: AnimatedOpacity(opacity: opacity, duration: Duration(seconds: 1),child:Text(
                            AppLocalizations.of(context)!.translate("login"),
                            style:GoogleFonts.roboto(
                              textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?MediaQuery.of(context).size.width*0.02:MediaQuery.of(context).size.width*0.04),
                            )
                        ),),
                      ),
                    ),visible: !kIsWeb,),
                    Container(
                        decoration: enableAssistance?BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          boxShadow : [BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              offset: Offset(0,3),
                              blurRadius: 100
                          )],
                          color : Color.fromRGBO(255, 255, 255, 1),
                        ):null,
                      width: kIsWeb?MediaQuery.of(context).size.width*0.2:MediaQuery.of(context).size.width*0.9,
                      child:InputDecorator(
                        decoration: InputDecoration(
                          errorText: showSelectTypeOfProviderErrorText?"Please Select A Provider Type":null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 3.0),
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: customTextColor, width: 3.0),
                          ),
                          //border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)),borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)),
                          contentPadding: kIsWeb?EdgeInsets.all(20):EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: false,
                            isExpanded: false,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: providerDropdownvalue,
                            style: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
                            // Down Arrow Icon
                            // Array list of items
                            items: providerList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                providerDropdownvalue = newValue!;
                                if(providerDropdownvalue!=providerList[0]){
                                  showSelectTypeOfProviderErrorText=false;
                                }
                                if(providerDropdownvalue==providerList[1]){
                                  showSelectGenderErrorText=false;
                                  print(providerDropdownvalue);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: enableAssistance?BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow : [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(0,3),
                            blurRadius: 100
                        )],
                        color : Color.fromRGBO(255, 255, 255, 1),
                      ):null,
                      width: kIsWeb?MediaQuery.of(context).size.width*0.2:MediaQuery.of(context).size.width*0.9,
                      child:InputDecorator(
                        decoration: InputDecoration(
                          errorText: showSelectGenderErrorText?"Please Select Your Gender":null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 3.0),
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: providerDropdownvalue==providerList[2]?customTextColor:Colors.grey, width: 3.0),
                          ),

                          //border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)),borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)),
                          contentPadding: kIsWeb?EdgeInsets.all(20):EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: false,
                            isExpanded: false,

                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: genderDropdownvalue,
                            style: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
                            // Down Arrow Icon
                            // Array list of items
                            items: genderList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: providerDropdownvalue==providerList[2]?(String? newValue) {
                              setState(() {
                                genderDropdownvalue = newValue!;
                                if(genderDropdownvalue!=genderList[0]){
                                  showSelectGenderErrorText=false;
                                }
                              });
                            }:null,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    //SizedBox(height: 20,),
                    SizedBox(
                      width: kIsWeb?MediaQuery.of(context).size.width*0.2:MediaQuery.of(context).size.width*0.9,
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
                              print(providerDropdownvalue);
                              print(genderDropdownvalue);
                              //If a Doctor with Gender
                              if(providerDropdownvalue==providerList[2] && genderDropdownvalue!=genderList[0]){
                                //Set DocSession here
                                userProviderSession.typeOfProvider=providerDropdownvalue;
                                userProviderSession.gender = genderDropdownvalue;
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (BuildContext context, Animation<double> animation,
                                        Animation<double> secondaryAnimation) =>
                                        AboutScreenOnboarding(),
                                    transitionDuration: const Duration(seconds: 0),
                                  ),);

                              }
                              //If a hospital without gender
                              else if(providerDropdownvalue==providerList[1]){
                                if(genderDropdownvalue==genderList[0]){
                                  userProviderSession.typeOfProvider=providerDropdownvalue;
                                  userProviderSession.gender = null;
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context, Animation<double> animation,
                                          Animation<double> secondaryAnimation) =>
                                          AboutScreenOnboarding(),
                                      transitionDuration: const Duration(seconds: 0),
                                    ),);
                                }

                              }
                              else{
                                if(genderDropdownvalue==genderList[0]){
                                  showSelectGenderErrorText = true;
                                }
                                if(providerDropdownvalue==providerList[0]){
                                  showSelectTypeOfProviderErrorText = true;
                                }
                                setState(() {

                                });

                              }


                            },
                            child: Text('Proceed',style: GoogleFonts.roboto(
                              textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: kIsWeb?size.width*0.025:size.width*0.07,fontWeight: FontWeight.w600),
                            ),)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        )
    ));
  }


}
