import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:techknowlogy/admin/newsletter/add_news.dart';
import 'package:techknowlogy/admin/newsletter/modify_news.dart';
import 'package:techknowlogy/constants.dart';

class NewsWrapper extends StatefulWidget {
  const NewsWrapper({Key? key}) : super(key: key);

  @override
  _NewsWrapperState createState() => _NewsWrapperState();
}

class _NewsWrapperState extends State<NewsWrapper> {
  int _selectedIndex = 0;
  final List _pages = [const AddNews(), const ModifyNews()];
  final TextStyle defaultTabStyle = const TextStyle();
  final TextStyle selectedTabStyle =
      const TextStyle(color: cerulean, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Align(
              alignment: const Alignment(-0.9, 0),
              child: SizedBox(
                height: 40.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_selectedIndex != 0) {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        }
                      },
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Add',
                            style: _selectedIndex == 0
                                ? selectedTabStyle
                                : defaultTabStyle,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_selectedIndex != 1) {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        }
                      },
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Modify',
                            style: _selectedIndex == 1
                                ? selectedTabStyle
                                : defaultTabStyle,
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
