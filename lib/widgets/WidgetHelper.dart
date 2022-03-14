import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:true_care_pharmacy/main.dart';

import '../app_localizations.dart';
import '../helper/globals.dart';

class WidgetHelper extends StatefulWidget {
  @override
  _WidgetHelperState createState() => _WidgetHelperState();

  CustomDatePickerTextField(String labelText,String? prefixText,String? errorText,String hintText,TextEditingController controller,BuildContext context){
    var size = MediaQuery.of(context).size;
    hintText = AppLocalizations.of(context)!.translate(hintText);
    return Container(
      decoration: enableAssistance?BoxDecoration(
        borderRadius : BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow : [BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0,3),
            blurRadius: 100
        )],
        color : Color.fromRGBO(255, 255, 255, 1),
      ):null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding:EdgeInsets.all(8) ,child: Text(AppLocalizations.of(context)!.translate(labelText),style: GoogleFonts.roboto(
            textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.01:size.width*0.05,fontWeight: FontWeight.w600),
          )),),
          TextField(
            style: GoogleFonts.roboto(
              textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
            ),
            controller: controller, //editing controller of this TextField
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: customTextColor,width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: customTextColor,width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: InputBorder.none,
              prefixStyle: GoogleFonts.roboto(
                textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
              ),
              errorText: errorText,
              prefixIcon: prefixText!=null?Padding(padding: EdgeInsets.all(10), child: Text('$prefixText',style: GoogleFonts.roboto(
                textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
              ),)):null,
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w400),
              ),
              contentPadding:EdgeInsets.only(top:kIsWeb?size.height*0.032:size.height*0.025,bottom: kIsWeb?size.height*0.032:size.height*0.025),
              /*focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),*/
            ),
            readOnly: true,  //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context, initialDate: DateTime.now(),
                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101)
              );

              if(pickedDate != null ){
                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                controller.text = formattedDate;
              }else{
                print("Date is not selected");
              }
            },
          )
        ],
      ),
    );
  }


  CustomTextField(String labelText,String? prefixText,String? errorText,String hintText,TextEditingController controller,BuildContext context) {
    var size = MediaQuery.of(context).size;
    hintText = AppLocalizations.of(context)!.translate(hintText);
    return
      Container(
      width: MediaQuery.of(context).size.width*0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding:EdgeInsets.all(8) ,child: Text(AppLocalizations.of(context)!.translate(labelText),style: GoogleFonts.roboto(
            textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.01:size.width*0.05,fontWeight: FontWeight.w600),
          )),),
          Container(
              child: TextField(
                cursorColor: customTextColor,
                controller: controller,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customTextColor,width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customTextColor,width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: InputBorder.none,
                  prefixStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
                  ),
                  errorText: errorText,
                  prefixIcon: prefixText!=null?Padding(padding: EdgeInsets.all(10), child: Text('$prefixText',style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.015:size.width*0.05,fontWeight: FontWeight.w600),
                  ),)):null,
                  hintText: hintText,
                  hintStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w400),
                  ),
                  contentPadding:EdgeInsets.only(top:kIsWeb?size.height*0.032:size.height*0.025,bottom: kIsWeb?size.height*0.032:size.height*0.025),
                  /*focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),*/
                ),
              ),

              decoration: enableAssistance?BoxDecoration(
                borderRadius : BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow : [BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0,3),
                    blurRadius: 100
                )],
                color : Color.fromRGBO(255, 255, 255, 1),
              ):null,
          )
        ],
      ),
    );
  }


  CustomPasswordField(String labelText,String? prefixText,String? errorText,String hintText,TextEditingController controller,BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      Container(
        width: MediaQuery.of(context).size.width*0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding:EdgeInsets.all(8) ,child: Text(AppLocalizations.of(context)!.translate(labelText),style: GoogleFonts.roboto(
              textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?size.width*0.01:size.width*0.2 ,fontWeight: FontWeight.w600),
            )),),
            Container(
              child: TextField(
                obscureText: true,
                cursorColor: customTextColor,
                controller: controller,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: size.width*0.015,fontWeight: FontWeight.w600),
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customTextColor,width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customTextColor,width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: InputBorder.none,
                  prefixStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: size.width*0.015,fontWeight: FontWeight.w600),
                  ),
                  errorText: errorText,
                  prefixIcon: prefixText!=null?Padding(padding: EdgeInsets.all(10), child: Text('$prefixText',style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: size.width*0.015,fontWeight: FontWeight.w600),
                  ),)):null,
                  hintText: hintText,
                  hintStyle: GoogleFonts.roboto(
                    textStyle: const TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w400),
                  ),
                  contentPadding:EdgeInsets.only(top:size.height*0.032,bottom: size.height*0.032),
                  /*focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),*/
                ),
              ),

              decoration: enableAssistance?const BoxDecoration(
                borderRadius : BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow : [BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0,3),
                    blurRadius: 100
                )],
                color : Color.fromRGBO(255, 255, 255, 1),
              ):null,
            )
          ],
        ),
      );
  }

  TitleTextCustom(String first,String last,BuildContext context) {
    return RichText(
      textAlign: kIsWeb?TextAlign.center:TextAlign.start,
      text: TextSpan(
          text: AppLocalizations.of(context)!.translate(first),
          style:GoogleFonts.roboto(
            textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.08),
          ),
          children: <TextSpan>[
            TextSpan(text: ' ,\n'+ AppLocalizations.of(context)!.translate(last),
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: kIsWeb?MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.08,fontWeight: FontWeight.w700),
                ))
          ]
      ),
    );
  }

  TitleTextAnimatedCustom(String first,String last,BuildContext context) {
    return Column(

      children: [
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              AppLocalizations.of(context)!.translate(first),
              textStyle: GoogleFonts.roboto(
                textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: MediaQuery.of(context).size.width*0.09),
              ),
              speed: const Duration(milliseconds: 150),
            ),
          ],

          //totalRepeatCount: 4,
          //pause: const Duration(milliseconds: 100),
          //displayFullTextOnTap: true,
          //stopPauseOnTap: true,
        ),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              AppLocalizations.of(context)!.translate(last),
              textStyle: GoogleFonts.roboto(
                textStyle: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.w700),
              ),
              speed: const Duration(milliseconds: 150),
            ),
          ],

          //totalRepeatCount: 4,
          //pause: const Duration(milliseconds: 100),
          //displayFullTextOnTap: true,
          //stopPauseOnTap: true,
        )
      ],
    );
  }
}

class _WidgetHelperState extends State<WidgetHelper> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
