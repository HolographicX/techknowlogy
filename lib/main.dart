import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:techknowlogy/admin/admin.dart';
import 'package:techknowlogy/admin/enter_admin_password.dart';
import 'package:techknowlogy/constants.dart';
import 'package:techknowlogy/pages/home.dart';
import 'package:techknowlogy/pages/newsletter.dart';
import 'package:techknowlogy/pages/talks.dart';
import 'package:techknowlogy/pages/view_news.dart';
import 'package:techknowlogy/pages/view_talk.dart';
import 'package:techknowlogy/secrets.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

final routes = RouteMap(
  routes: {
    '/': (route) => const TabPage(
          child: Wrapper(),
          paths: ['/home', '/talks', '/newsletter'],
        ),
    '/home': (route) => const MaterialPage(child: Home()),
    '/viewtalk/:id': (route) => MaterialPage(
          child: ViewTalk(talkID: route.pathParameters['id']),
        ),
    '/talks': (route) => const MaterialPage(child: Talks()),
    '/newsletter': (route) => const MaterialPage(child: Newsletter()),
    '/viewnews/:id': (route) => MaterialPage(
          child: ViewNews(newsID: route.pathParameters['id']),
        ),
    '/admin': (route) => const MaterialPage(child: EnterAdminPassword()),
  },
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  // setPathUrlStrategy();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: (context, widget) => ResponsiveWrapper.builder(const MyApp(),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScaleDown(900, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
        background: Container(color: const Color(0xFFF5F5F5))),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
        routeInformationParser: const RoutemasterParser(),
        title: 'Tech-know-logy club',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: ceruleanSelect,
            ),
            scaffoldBackgroundColor: primaryColor,
            backgroundColor: primaryColor,
            fontFamily: 'FiraSans'),
      );
    });
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
    final tabPage = TabPage.of(context);
    switch (tabPage.index) {
      case 0:
        homeColor = cerulean;
        homeFont = FontWeight.w500;
        break;
      case 1:
        talksColor = cerulean;
        talksFont = FontWeight.w500;
        break;
      case 2:
        newsColor = cerulean;
        newsFont = FontWeight.w500;
        break;
    }
    const List pages = [Home(), Talks(), Newsletter()];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        // TabBarView(
        //   controller: tabPage.controller,
        //   children: [
        //     for (final stack in tabPage.stacks)
        //       PageStackNavigator(stack: stack),
        //   ],
        // ),
        pages[tabPage.index],
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
                                if (tabPage.index != 0)
                                  {
                                    setState(() {
                                      homeColor = defaultabColor;
                                      homeFont = FontWeight.normal;
                                    })
                                  }
                              },
                            ),
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
                                      if (tabPage.index != 1)
                                        {
                                          setState(() {
                                            talksColor = defaultabColor;
                                            talksFont = FontWeight.normal;
                                          })
                                        },
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
                                if (tabPage.index != 2)
                                  {
                                    setState(() {
                                      newsColor = defaultabColor;
                                      newsFont = FontWeight.normal;
                                    })
                                  }
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
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
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
                                if (tabPage.index != 0)
                                  {
                                    setState(() {
                                      homeColor = defaultabColor;
                                      homeFont = FontWeight.normal;
                                    })
                                  }
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
                                      if (tabPage.index != 1)
                                        {
                                          setState(() {
                                            talksColor = defaultabColor;
                                            talksFont = FontWeight.normal;
                                          })
                                        },
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
                                if (tabPage.index != 2)
                                  {
                                    setState(() {
                                      newsColor = defaultabColor;
                                      newsFont = FontWeight.normal;
                                    })
                                  }
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
