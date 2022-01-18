import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:techknowlogy/api/firebase_api.dart';
import 'package:techknowlogy/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:techknowlogy/models/talk_model.dart';


class Talks extends StatefulWidget {
  const Talks({Key? key}) : super(key: key);

  @override
  _TalksState createState() => _TalksState();
}

class _TalksState extends State<Talks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseApi.readTalks(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const SelectableText('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: kLoadingIndicator);
            }
            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 25.sp, vertical: 30.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const OpeningTexts(),
                    const SizedBox(height: 150),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 800
                          ? true
                          : false,
                      child: latestTalk(Talk.fromJson(snapshot.data!.docs.first
                          .data()! as Map<String, dynamic>)),
                    ),
                    Visibility(
                      visible: MediaQuery.of(context).size.width > 800
                          ? true
                          : false,
                      child: const SizedBox(
                        height: 20,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: SelectableText(
                        "All talks",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 34,
                            color: ceruleanHeading),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth > 400) {
                        return GridView.extent(
                            // crossAxisCount:
                            // MediaQuery.of(context).size.width > 1200 ? 3 : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            primary: true,
                            maxCrossAxisExtent: 400.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              Talk talkfromdata = Talk.fromJson(data);
                              // if (snapshot.data!.docs.first.data().toString() !=
                              //     data.toString()) {
                              return talkGrid(talkfromdata);
                              // }
                            }).toList());
                      } else {
                        return ListView(
                            // crossAxisCount:
                            // MediaQuery.of(context).size.width > 1200 ? 3 : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            primary: true,
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              Talk talkfromdata = Talk.fromJson(data);
                              // if (snapshot.data!.docs.first.data().toString() !=
                              //     data.toString()) {
                              return talkGrid(talkfromdata);
                              // }
                            }).toList());
                      }
                    }),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget latestTalk(Talk talkfromdata) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          String talkId = talkfromdata.id as String;
          Routemaster.of(context).push("/viewtalk/$talkId");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const Alignment(-0.8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SelectableText(
                    "Latest",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 34,
                        color: ceruleanHeading),
                  ),
                  Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: ceruleanHeading,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 230,
                          width: 320,
                          decoration: BoxDecoration(
                              color: Color(int.parse(
                                          talkfromdata.bgHex.toString(),
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
                              image:
                                  NetworkImage(talkfromdata.imglink.toString()),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 200,
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SelectableText(
                            DateFormat.yMMMMd('en_US')
                                .format(talkfromdata.date as DateTime),
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: SelectableText(
                              talkfromdata.title.toString(),
                              style: kHeading1Style.copyWith(fontSize: 50),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectableText(
                            talkfromdata.description.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                            maxLines: 4,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget talkGrid(Talk talkfromdata) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          String talkId = talkfromdata.id as String;
          Routemaster.of(context).push("/viewtalk/$talkId");
        },
        child: SizedBox(
          height: 340,
          width: 230,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 230,
                            decoration: BoxDecoration(
                                color: Color(int.parse(
                                            talkfromdata.bgHex.toString(),
                                            radix: 16) +
                                        0xFF000000)
                                    .withOpacity(0.3),
                                borderRadius: kBorderRadius),
                          ),
                          Container(
                            height: 130,
                            width: 80,
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 130,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SelectableText(
                              DateFormat.yMMMMd('en_US')
                                  .format(talkfromdata.date as DateTime),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: SelectableText(
                                talkfromdata.title.toString(),
                                style: kHeading1Style.copyWith(fontSize: 30),
                              ),
                            ),
                            SelectableText(
                              talkfromdata.description.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 12),
                              maxLines: 4,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OpeningTexts extends StatefulWidget {
  const OpeningTexts({
    Key? key,
  }) : super(key: key);

  @override
  State<OpeningTexts> createState() => _OpeningTextsState();
}

class _OpeningTextsState extends State<OpeningTexts> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to our",
                  style: kHeading1Style.copyWith(fontSize: 45),
                ),
                Text(
                  "Monthly Tech Talks",
                  style: kHeading1Style.copyWith(fontSize: 45, color: cyanDark),
                )
              ],
            ),
            const SizedBox(
              width: 300,
              child: Text(
                  "We host tech-talks about popular topics in the world of technology every month. This page contains recordings and key insights of all of our talks held."),
            )
          ],
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to our",
                    style: kHeading1Style.copyWith(fontSize: 45),
                  ),
                  Text(
                    "Monthly Tech Talks",
                    style:
                        kHeading1Style.copyWith(fontSize: 45, color: cyanDark),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 300,
                child: Text(
                    "We host tech-talks about popular topics in the world of technology every month. This page contains recordings and key insights of all of our talks held."),
              )
            ],
          ),
        );
      }
    });
  }
}
