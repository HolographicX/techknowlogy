
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:techknowlogy/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _borderWidth = 15;
  double _opacity = 1;

  @override
  void initState(){
    super.initState();
    
      }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var presentationWidth = MediaQuery.of(context).size.width *0.9;
    var presentationHeight = MediaQuery.of(context).size.height *0.7;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 2,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('background-top-home.png'),
                        fit: BoxFit.fill,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('wave-top-home.png'),
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Positioned(
                  top: 150,
                  left: width > 500 ? 60 : null,
                  child: Text("This is the",
                      style: kHeading1Style.copyWith(
                        fontSize: 40,
                      )),
                ),
                Positioned(
                  top: 200,
                  left: width > 500 ? 60 : null,
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const  LinearGradient(
                                colors: <Color>[
                                  Color(0xff1D1D4E),
                                  Color(0xff56B3B3)
                                ],
                              ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),

                    child: Text(
                      "Tech-know-logy Club",
                        style: kHeading1Style.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w600
                                  ),
                                  ),
                  ),
                ),
                Positioned(
                  top:  330,
                  right: width > 500 ? 30 : null,
                
                  child: SizedBox(
                    width: 400,
                    child: SelectableText(
                        "Here, we learn about technology beyond the classroom.",
                        textAlign:
                            width > 500 ? TextAlign.left : TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                        )),
                  ),
                ),
                Positioned(
                    bottom: width > 500 ? 130 : 20,
                    left: width > 500 ? 200 : null,
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xddace0e0),
                            width: 5,
                          ),
                          // image: DecorationImage(
                          //   image: const AssetImage('ButtonEllipse.png'),
                          //   colorFilter: ColorFilter.mode(
                          //       Colors.white.withAlpha(5), BlendMode.overlay),
                          //   fit: BoxFit.fill,
                          // ),
                        ))),
                Positioned(
                    bottom: width > 500 ? 150 : 40,
                    left: width > 500 ? 150 : null,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onHover: (e) {
                        setState(() {
                          _borderWidth = 4;
                          _opacity = 0;
                        });
                      },
                      onExit: (e) {
                        setState(() {
                          _borderWidth = 15;
                          _opacity = 1;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          launch("https://forms.gle/7Crhiz7YUmdqjCTaA");
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          height: 55,
                          width: 200,
                          decoration: BoxDecoration(
                            color:
                                const Color(0xff8ECCCC).withOpacity(_opacity),
                            border: Border.all(
                              color: const Color(0xff8ECCCC),
                              width: _borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(142, 204, 204, 0.8),
                                  offset: Offset(0, 9),
                                  blurRadius: 40)
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Sign me up!",
                              style: TextStyle(
                                  fontFamily: "FiraCode", fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Stack(
              // alignment: Alignment.center,
              children: [
                Container(
                    height: width <= 500 ? MediaQuery.of(context).size.height * 3: MediaQuery.of(context).size.height*2.1,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('background-bottom-home.png'),
                        fit: BoxFit.fill,
                      ),
                    )),
                Align(
                  alignment: const Alignment(0, -1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: width > 500 ? 0 : 50,
                      ),
                      Text(
                        "About us",
                        style: kHeading1Style.copyWith(fontSize: 40),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width > 500 ? 500 : 300,
                        child: SelectableText(
                          "Tech-know-logy Club was founded by Dhriti Reddy and Mrudgandh Kumbhar, students of B.D. Somani International School, in 2021. Our purpose is to spread awareness and be in-align with the latest technological happenings around the globe. We believe technology alone can tremendously transform industries as a whole. As numerous state-of-the-art trends and movements in technology emerge, join Tech-know-logy Club to be at the forefront of this paradigm.",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.9)),
                        ),
                      ),
                      
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: width > 500 ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [Card1(), Card2()],
                        ),
                      ),
                      Visibility(
                        visible: width <= 500 ? true : false,
                        child: Column(
                          children:  const [
                             Card1(),
                             SizedBox(
                              height: 60,
                            ),
                            Card2(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: MediaQuery.of(context).size.width < 500 ? false: true,
                        child: Html(data: """
                            <iframe src="https://drive.google.com/file/d/15gqtByEjd11E1ypKGQ7CP30dWFpiJsm-/preview" width="$presentationWidth" height="$presentationHeight" align="middle" allow="autoplay"></iframe>
                            """,),
                      ),
                      const SizedBox(height: 90,),
                      const Align(
                  alignment: Alignment(0, -1),
                  child: Text("Icons from Flaticon", style: TextStyle(color: Colors.black54),)),
                    ],
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Card1 extends StatelessWidget {
  const Card1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          launch("https://drive.google.com/file/d/1-cfgVlvrx2DuwTZZb45JLIASMu0LKO2v/view");
        },
        child: Container(
          height: 220,
          width: 320,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 53,
                offset: const Offset(9, 16))
          ], color: const Color(0xffC4CADD), borderRadius: kBorderRadius),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Read our bylaws",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              SizedBox(
                height: 110,
                width: 90,
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/1355/1355236.png"),
              )
            ],
          )),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          launch("https://github.com/HolographicX/techknowlogy");
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 220,
              width: 320,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 53,
                    offset: const Offset(9, 16))
              ], color: const Color(0xffE8D7DC), borderRadius: kBorderRadius),
      
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Star this project on GitHub",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 300,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child:  Text(
                        "Like this website? The best way to show your appreciation\nis to star the repository!",
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/179/179323.png"),
                      ),
                      const SizedBox(width: 20,),
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/711/711284.png"),
                      ),
                    ],
                  )
                ],
              )),
            ),
            Transform.translate(
              offset: const Offset(-150,-100),
              child: Align(
                alignment: const Alignment(0, 0),
                child: SizedBox(
                                          height: 48,
                                          width: 48,
                                          child: Image.network("https://cdn-icons-png.flaticon.com/512/616/616489.png"),
                                        ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
