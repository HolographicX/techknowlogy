import 'package:flutter/material.dart';
import 'package:techknowlogy/admin/admin.dart';
import 'package:techknowlogy/constants.dart';
import 'package:techknowlogy/pages/home.dart';
import 'package:techknowlogy/pages/newsletter.dart';
import 'package:techknowlogy/pages/talks.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(
  routes: {
    '/': (route) => const TabPage(
          child: MyApp(),
          paths: ['/home', '/talks', '/newsletter'],
        ),
    '/home': (route) => const MaterialPage(child: Home()),
    '/talks': (route) => const MaterialPage(child: Talks()),
    '/newsletter': (route) => const MaterialPage(child: Newsletter()),
  },
);

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: const RoutemasterParser(),
      title: 'Tech-know-logy club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.red,
            selectionColor: ceruleanSelect,
            selectionHandleColor: Colors.blue,
          ),
          scaffoldBackgroundColor: primaryColor,
          fontFamily: 'FiraSans'),
      //home: const Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  static const List pages = [
    Home(),
    Talks(),
    Newsletter(),
  ];
  static const defaultabColor = Color(0xff8C8C85);
  Color aboutColor = defaultabColor;
  Color talksColor = defaultabColor;
  Color newsColor = defaultabColor;
  FontWeight aboutFont = FontWeight.normal;
  FontWeight talksFont = FontWeight.normal;
  FontWeight newsFont = FontWeight.normal;
  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        TabBarView(
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'Tech-know-logy club',
                  style: TextStyle(
                      fontFamily: 'FiraCode',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                //const Expanded(child: SizedBox()),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.4,
                // ),
                SizedBox(
                  height: 50,
                  width: 400,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    bottom: TabBar(
                      indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                        color: cerulean,
                        width: 2,
                      )),
                      labelColor: cerulean,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontFamily: 'FiraSans'),
                      unselectedLabelColor: defaultabColor,
                      unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'FiraSans'),
                      controller: tabPage.controller,
                      tabs: const [
                        Tab(text: 'Home'),
                        Tab(text: 'Talks'),
                        Tab(
                          text: 'Newsletter',
                        )
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: MouseRegion(
                          child: Text(
                            'About',
                            style: TextStyle(
                                color: aboutColor,
                                fontSize: 16,
                                fontWeight: aboutFont),
                          ),
                          cursor: SystemMouseCursors.click,
                          onHover: (event) => {
                            setState(() {
                              aboutColor = cerulean;
                              aboutFont = FontWeight.w500;
                            })
                          },
                          onExit: (event) => {
                            setState(() {
                              aboutColor = defaultabColor;
                              aboutFont = FontWeight.normal;
                            })
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
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
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
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
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
