import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:routemaster/routemaster.dart';
import 'package:techknowlogy/models/talk_model.dart';
import 'package:techknowlogy/models/utils.dart';
import 'package:techknowlogy/pages/talks.dart';
import '../constants.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';
import 'home.dart';
import 'newsletter.dart';

class ViewTalk extends StatefulWidget {
  final String? talkID;
  const ViewTalk({Key? key, required this.talkID}) : super(key: key);

  @override
  State<ViewTalk> createState() => _ViewTalkState();
}

class _ViewTalkState extends State<ViewTalk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('talks')
              .doc(widget.talkID)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text(
                  "Something went wrong, try reloading the page.");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Talk does not exist!");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: kLoadingIndicator);
            }

            final talkfromdata = Talk(
              title: snapshot.data!['title'],
              bgHex: snapshot.data!['bgHex'],
              imglink: snapshot.data!['imglink'],
              date: Utils.toDateTime(snapshot.data!['date']),
              recordingUrl: snapshot.data!['recordingUrl'],
              keyInsights: snapshot.data!['keyInsights'],
              description: snapshot.data!['description'],
              id: snapshot.data!['id'],
            );
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 90, 30, 0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SelectableText(
                                talkfromdata.title as String,
                                style: kHeading1Style.copyWith(fontSize: 35),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          SizedBox(
                            width: 320,
                            child: Column(
                              children: [
                                Align(
                                  alignment: const Alignment(-0.95, 0),
                                  child: Text(
                                    Utils.formatDate(
                                        talkfromdata.date as DateTime),
                                    style: kLightTextStyle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 230,
                                      width: 320,
                                      decoration: BoxDecoration(
                                          color: Color(int.parse(
                                                      talkfromdata.bgHex
                                                          .toString(),
                                                      radix: 16) +
                                                  0xFF000000)
                                              .withOpacity(0.3),
                                          borderRadius: kBorderRadius),
                                    ),
                                    Container(
                                      height: 180,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              talkfromdata.imglink.toString()),
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment(-0.9, 0),
                            child: SelectableText(
                              "Recording",
                              style: kHeading1Style,
                            ),
                          ),
                          Html(data: """
                          <iframe src="${talkfromdata.recordingUrl}" width="640" height="480" align="middle" allow="autoplay"></iframe>
                          """),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible:
                                talkfromdata.keyInsights == "" ? false : true,
                            child: const Align(
                              alignment: Alignment(-1, 0),
                              child: SelectableText(
                                "Key Insights",
                                style: kHeading1Style,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Html(data: """
                            <p>${talkfromdata.keyInsights}</p>
                            """),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100.w, width: 100.w, child: const Header()),
                ],
              ),
            );
          }),
    );
  }
}

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool menuSelected = false;
  static const defaultabColor = Color(0xff8C8C85);
  Color homeColor = defaultabColor;
  Color talksColor = defaultabColor;
  Color newsColor = defaultabColor;
  FontWeight homeFont = FontWeight.normal;
  FontWeight talksFont = FontWeight.normal;
  FontWeight newsFont = FontWeight.normal;
  @override
  void initState() {
    homeColor = defaultabColor;
    talksColor = defaultabColor;
    newsColor = defaultabColor;
    homeFont = FontWeight.normal;
    newsFont = FontWeight.normal;
    talksFont = FontWeight.normal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List pages = [Home(), Talks(), Newsletter()];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        AnimatedPositioned(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500),
            left: menuSelected ? 0 : 100.w,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(color: primaryColor, boxShadow: [
                    BoxShadow(
                        color: menuSelected
                            ? Colors.black.withOpacity(0.15)
                            : Colors.transparent,
                        blurRadius: 5,
                        offset: const Offset(-3, 2))
                  ]),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: const Alignment(0, 0),
                    child: SizedBox(
                      height: 50.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Routemaster.of(context).replace('/home');
                              setState(() {
                                menuSelected = !menuSelected;
                                homeColor = cerulean;
                                homeFont = FontWeight.w500;
                                talksColor = defaultabColor;
                                talksFont = FontWeight.normal;
                                newsColor = defaultabColor;
                                newsFont = FontWeight.normal;
                              });
                            },
                            child: MouseRegion(
                                child: Text(
                                  'Home',
                                  style: TextStyle(
                                      color: homeColor,
                                      fontSize: 16,
                                      fontWeight: homeFont),
                                ),
                                cursor: SystemMouseCursors.click,
                                onHover: (event) => {
                                      setState(() {
                                        homeColor = cerulean;
                                        homeFont = FontWeight.w500;
                                      })
                                    },
                                onExit: (event) => {
                                      setState(() {
                                        homeColor = defaultabColor;
                                        homeFont = FontWeight.normal;
                                      })
                                    }),
                          ),
                          GestureDetector(
                            onTap: () {
                              menuSelected = !menuSelected;
                              Routemaster.of(context).replace('/talks');
                              setState(() {
                                talksColor = cerulean;
                                talksFont = FontWeight.w500;
                                homeColor = defaultabColor;
                                homeFont = FontWeight.normal;
                                newsColor = defaultabColor;
                                newsFont = FontWeight.normal;
                              });
                            },
                            child: MouseRegion(
                                child: Text(
                                  'Talks',
                                  style: TextStyle(
                                      color: talksColor,
                                      fontSize: 16,
                                      fontWeight: talksFont),
                                ),
                                cursor: SystemMouseCursors.click,
                                onHover: (event) => {
                                      setState(() {
                                        talksColor = cerulean;
                                        talksFont = FontWeight.w500;
                                      })
                                    },
                                onExit: (event) => {
                                      setState(() {
                                        talksColor = defaultabColor;
                                        talksFont = FontWeight.normal;
                                      })
                                    }),
                          ),
                          GestureDetector(
                            onTap: () {
                              menuSelected = !menuSelected;
                              Routemaster.of(context).replace('/newsletter');
                              setState(() {
                                newsColor = cerulean;
                                newsFont = FontWeight.w500;
                                homeColor = defaultabColor;
                                homeFont = FontWeight.normal;
                                talksColor = defaultabColor;
                                talksFont = FontWeight.normal;
                              });
                            },
                            child: MouseRegion(
                              child: Text(
                                'Newsletter',
                                style: TextStyle(
                                    color: newsColor,
                                    fontSize: 16,
                                    fontWeight: newsFont),
                              ),
                              cursor: SystemMouseCursors.click,
                              onHover: (event) => {
                                setState(() {
                                  newsColor = cerulean;
                                  newsFont = FontWeight.w500;
                                })
                              },
                              onExit: (event) => {
                                setState(() {
                                  newsColor = defaultabColor;
                                  newsFont = FontWeight.normal;
                                })
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )), //menu (closed by default)
        Align(
          //header
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Tech-know-logy club',
                  style: TextStyle(
                      fontFamily: 'FiraCode',
                      fontWeight: FontWeight.w600,
                      fontSize: 3.h),
                ),

                const Expanded(child: SizedBox()),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.3,
                // ),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth > 250) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Routemaster.of(context).replace('/home');
                              setState(() {
                                homeColor = cerulean;
                                homeFont = FontWeight.w500;
                                talksColor = defaultabColor;
                                talksFont = FontWeight.normal;
                                newsColor = defaultabColor;
                                newsFont = FontWeight.normal;
                              });
                            },
                            child: MouseRegion(
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    color: homeColor,
                                    fontSize: 16,
                                    fontWeight: homeFont),
                              ),
                              cursor: SystemMouseCursors.click,
                              onHover: (event) => {
                                setState(() {
                                  homeColor = cerulean;
                                  homeFont = FontWeight.w500;
                                })
                              },
                              onExit: (event) => {
                                setState(() {
                                  homeColor = defaultabColor;
                                  homeFont = FontWeight.normal;
                                })
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Routemaster.of(context).replace('/talks');
                              setState(() {
                                talksColor = cerulean;
                                talksFont = FontWeight.w500;
                                homeColor = defaultabColor;
                                homeFont = FontWeight.normal;
                                newsColor = defaultabColor;
                                newsFont = FontWeight.normal;
                              });
                            },
                            child: MouseRegion(
                                child: Text(
                                  'Talks',
                                  style: TextStyle(
                                      color: talksColor,
                                      fontSize: 16,
                                      fontWeight: talksFont),
                                ),
                                cursor: SystemMouseCursors.click,
                                onHover: (event) => {
                                      setState(() {
                                        talksColor = cerulean;
                                        talksFont = FontWeight.w500;
                                      })
                                    },
                                onExit: (event) => {
                                      setState(() {
                                        talksColor = defaultabColor;
                                        talksFont = FontWeight.normal;
                                      })
                                    }),
                          ),
                          GestureDetector(
                            onTap: () {
                              Routemaster.of(context).replace('/newsletter');
                              setState(() {
                                newsColor = cerulean;
                                newsFont = FontWeight.w500;
                                homeColor = defaultabColor;
                                homeFont = FontWeight.normal;
                                talksColor = defaultabColor;
                                talksFont = FontWeight.normal;
                              });
                            },
                            child: MouseRegion(
                              child: Text(
                                'Newsletter',
                                style: TextStyle(
                                    color: newsColor,
                                    fontSize: 16,
                                    fontWeight: newsFont),
                              ),
                              cursor: SystemMouseCursors.click,
                              onHover: (event) => {
                                setState(() {
                                  newsColor = cerulean;
                                  newsFont = FontWeight.w500;
                                })
                              },
                              onExit: (event) => {
                                setState(() {
                                  newsColor = defaultabColor;
                                  newsFont = FontWeight.normal;
                                })
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      //mobile menu
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            menuSelected = !menuSelected;
                          });
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(menuSelected ? Icons.close : Icons.menu),
                              Text(
                                menuSelected ? ' Close' : '  Menu',
                                style: TextStyle(fontSize: 8.sp),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
