import 'package:flutter/material.dart';
import 'package:techknowlogy/admin/wrappers/newswrapper.dart';
import 'package:techknowlogy/admin/wrappers/talkswrapper.dart';
import 'package:techknowlogy/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _selectedIndex = 0;
  final List _pages = [const TalksWrapper(), const NewsWrapper()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _pages[_selectedIndex],
          Align(
            alignment: const Alignment(0, -0.95),
            child: Container(
              height: 10.h,
              width: 30.w,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: const Color(0xffD4DFED).withAlpha(150),
                  boxShadow: [kBoxShadow1]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: GNav(
                    hoverColor: ceruleanSelect,
                    tabBorderRadius: 15,
                    curve: Curves.easeIn, // tab animation curves
                    duration: const Duration(
                        milliseconds: 400), // tab animation duration
                    gap: 8, // the tab button gap between icon and text
                    color: Colors.grey[800], // unselected icon color
                    activeColor: darkblue, // selected icon and text color
                    iconSize: 24, // tab button icon size
                    tabBackgroundColor: darkblue
                        .withOpacity(0.1), // selected tab background color
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.w,
                        vertical: 1.5.h), // navigation bar padding
                    tabs: const [
                      GButton(
                        icon: LineIcons.microphone,
                        text: 'Talks',
                      ),
                      GButton(
                        icon: LineIcons.newspaper,
                        text: 'News',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
