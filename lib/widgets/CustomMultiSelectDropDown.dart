import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_care_pharmacy/helper/globals.dart';

class CustomMultiselectDropDown extends StatefulWidget {
  final Function(List<String>) selectedList;
  final List<String> listOFStrings;

  CustomMultiselectDropDown(
      {required this.selectedList, required this.listOFStrings});

  @override
  createState() {
    return new _CustomMultiselectDropDownState();
  }
}

class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
  List<String> listOFSelectedItem = [];
  String selectedText = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
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
      ),
      child: ExpansionTile(
        iconColor: customTextColor,
        collapsedIconColor: customTextColor,
        title: Text(
          listOFSelectedItem.isEmpty ? "Select" : listOFSelectedItem.join(', '),
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: customTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
        ),
        children: <Widget>[
          new ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.listOFStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: _ViewItem(
                    item: widget.listOFStrings[index],
                    selected: (val) {
                      selectedText = val;
                      if (listOFSelectedItem.contains(val)) {
                        listOFSelectedItem.remove(val);
                      } else {
                        listOFSelectedItem.add(val);
                      }
                      widget.selectedList(listOFSelectedItem);
                      setState(() {});
                    },
                    itemSelected: listOFSelectedItem
                        .contains(widget.listOFStrings[index])),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ViewItem extends StatelessWidget {
  String item;
  bool itemSelected;
  final Function(String) selected;

  _ViewItem(
      {required this.item, required this.itemSelected, required this.selected});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
      EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                selected(item);
              },
              activeColor: customTextColor,
            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          Text(
            item,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: primaryColorOfApp,
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}