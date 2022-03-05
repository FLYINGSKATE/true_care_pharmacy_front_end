import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_care_pharmacy/main.dart';
import 'package:true_care_pharmacy/network/api_callback_listener.dart';

import '../helper/globals.dart';
import '../network/api_action.dart';
import '../network/api_request.dart';
import '../network/api_url.dart';
import '../network/http_methods.dart';
import '../widgets/WidgetHelper.dart';

import 'package:http/http.dart' as http;

class RegistrationScreen3 extends StatefulWidget {
  @override
  _RegistrationScreen3State createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> implements ApiCallBackListener {
  TextEditingController desireedUserIdTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
                  WidgetHelper().TitleTextCustom("Last Step","for Registration"),
                  SizedBox(height: 20,),
                  WidgetHelper().CustomTextField("Desired User ID","",null,"",desireedUserIdTextEditingController),
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),
                  WidgetHelper().CustomTextField("A Strong Password","",null,"",passwordTextEditingController),
                  SizedBox(height: 10,),
                  WidgetHelper().CustomTextField("Confirm Password",null,null,"",passwordTextEditingController),
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
                          onPressed: () async {
                              //Call Api Here
                            print('badsha');
                            print(docSession.toJson().values);
                            docSession.password = passwordTextEditingController.text;
                            docSession.userId = desireedUserIdTextEditingController.text;
                            Map<String, String> body = {};

                            body["user_id"]=docSession.userId.toString();
                            body["name"]=docSession.name.toString();
                            body["speciality"]=docSession.speciality.toString();
                            body["phone_number"]=docSession.phoneNumber.toString();
                            body["email_id"]=docSession.emailId.toString();
                            body["password"]=docSession.password.toString();

                            print(body.toString());
                            print(docSession.toString());

                            var headers = {
                              'Content-Type': 'application/json',
                              "Access-Control_Allow_Origin": "*"
                            };

                            var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/add'));
                            request.body = json.encode(body);
                            request.headers.addAll(headers);

                            http.StreamedResponse response = await request.send();

                            if (response.statusCode == 200) {
                              print("await response.stream.bytesToString()");
                              print(await response.stream.bytesToString());
                            }
                            else {
                              print("response.reasonPhrase");
                              print(response.reasonPhrase);
                            }

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
                            textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 24,fontWeight: FontWeight.w600),
                          ),)),
                    ),
                  ),
                ],
              ),
            )
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
