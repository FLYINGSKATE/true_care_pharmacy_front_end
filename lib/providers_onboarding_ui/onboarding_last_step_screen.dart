import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:true_care_pharmacy/main.dart';
import 'package:true_care_pharmacy/network/api_callback_listener.dart';

import '../app_localizations.dart';
import '../helper/globals.dart';
import '../network/api_action.dart';
import '../network/api_request.dart';
import '../network/api_url.dart';
import '../network/http_methods.dart';
import '../widgets/WidgetHelper.dart';

import 'package:http/http.dart' as http;

class OnBoardingLastStepScreen extends StatefulWidget {
  @override
  _OnBoardingLastStepScreenState createState() => _OnBoardingLastStepScreenState();
}

class _OnBoardingLastStepScreenState extends State<OnBoardingLastStepScreen> with TickerProviderStateMixin  implements ApiCallBackListener {
  TextEditingController desireedUserIdTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  late final AnimationController _controller;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    //initTts();
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
                    child: WidgetHelper().TitleTextCustom("last_step","for_reg",context),
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
                        child: WidgetHelper().CustomTextField("desired_user_id_label","",null,"",desireedUserIdTextEditingController,context),
                      ),
                      SizedBox(height: size.height*0.02,),
                      Container(
                        width:kIsWeb?size.width*0.2:size.width*0.9,
                        child: WidgetHelper().CustomPasswordField("password","",null,"",passwordTextEditingController,context),
                      ),
                      SizedBox(height: size.height*0.02,),
                      Visibility(child: Container(
                        width:kIsWeb?size.width*0.2:size.width*0.9,
                        child:WidgetHelper().CustomPasswordField("confirm_password","",null,"",passwordTextEditingController,context),
                      ),visible: !existingUserLogin,),
                      //SizedBox(height: 20,),
                      SizedBox(height: size.height*0.02,),
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
                              onPressed: () async {
                                //Call Api Here
                                // print('badsha');
                                // print(userProviderSession.toJson().values);
                                // userProviderSession.password = passwordTextEditingController.text;
                                // userProviderSession.userId = desireedUserIdTextEditingController.text;
                                // Map<String, String> body = {};
                                //
                                // body["user_id"]=userProviderSession.userId.toString();
                                // body["name"]=userProviderSession.name.toString();
                                // body["speciality"]=userProviderSession.speciality.toString();
                                // body["phone_number"]=userProviderSession.phoneNumber.toString();
                                // body["email_id"]=userProviderSession.emailId.toString();
                                // body["password"]=userProviderSession.password.toString();
                                //
                                // print(body.toString());
                                // print(userProviderSession.toString());
                                //
                                // var headers = {
                                //   'Content-Type': 'application/json',
                                //   "Access-Control_Allow_Origin": "*"
                                // };
                                //
                                // var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/add'));
                                // request.body = json.encode(body);
                                // request.headers.addAll(headers);
                                //
                                // http.StreamedResponse response = await request.send();
                                //
                                // if (response.statusCode == 200) {
                                //   print("await response.stream.bytesToString()");
                                //   print(await response.stream.bytesToString());
                                // }
                                // else {
                                //   print("response.reasonPhrase");
                                //   print(response.reasonPhrase);
                                // }

                                /*ApiRequest(
                                context: context,
                                apiCallBackListener: this,
                                showLoader: false,
                                isMultiPart: false,
                                encoding: null,
                                headers: {
                                  'Content-Type': 'application/json'
                                },
                                body: body,
                                httpType: HttpMethods.POST,
                                url: ApiUrl.addUser,
                                apiAction: ApiAction.addUser);*/
                              },
                              child: Text('Submit',style: GoogleFonts.roboto(
                                textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: size.width*0.025,fontWeight: FontWeight.w600),
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

  @override
  apiCallBackListener(String action, int statusCode, Map<String, dynamic> json) {
    print(action);
    switch (action) {
      case ApiAction.addUser:
        {
          print(json.toString());
          break;
        }
    }
  }
}
