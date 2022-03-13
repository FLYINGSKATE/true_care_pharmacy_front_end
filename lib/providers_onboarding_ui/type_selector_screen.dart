import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../helper/globals.dart';
import '../widgets/WidgetHelper.dart';

class SelectTypeOfProScreen extends StatefulWidget {
  @override
  _SelectTypeOfProScreenState createState() => _SelectTypeOfProScreenState();
}

class _SelectTypeOfProScreenState extends State<SelectTypeOfProScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  double opacity = 0.0;

  // Initial Selected Value
  String genderDropdownvalue = 'Select Your Gender';

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

  String providerDropdownvalue = 'Select Type of Provider';

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: kIsWeb?CrossAxisAlignment.start:CrossAxisAlignment.start,
                children: [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 1),
                    child: WidgetHelper().TitleTextCustom("Welcome","how_define",context),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.2,
                    child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_6e0qqtpa.json',controller: _controller,
                      onLoaded: (composition) {
                        // Configure the AnimationController with the duration of the
                        // Lottie file and start the animation.
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },),
                  ),
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width:3),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child:DropdownButton(
                            // Initial Value
                            value: genderDropdownvalue,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: genderList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                genderDropdownvalue = newValue!;
                              });
                            },
                            isExpanded: true, //make true to take width of parent widget
                            underline: Container(), //empty line
                            style: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: 20,fontWeight: FontWeight.w600),
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.black, //Icon color
                          )
                      )
                  ),
                  SizedBox(height: 20,),
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width:3),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child:DropdownButton(
                            // Initial Value
                            value: providerDropdownvalue,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
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
                              });
                            },
                            isExpanded: true, //make true to take width of parent widget
                            underline: Container(), //empty line
                            style: TextStyle(color: customTextColor, letterSpacing: .5,fontSize: 20,fontWeight: FontWeight.w600),
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.black, //Icon color
                          )
                      )
                  ),
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

                          },
                          child: Text('Proceed',style: GoogleFonts.roboto(
                            textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 24,fontWeight: FontWeight.w600),
                          ),)),
                    ),
                  ),
                ],
              )
            )
        )
    ));
  }
}
