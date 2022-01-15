import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:techknowlogy/api/firebase_api.dart';
import 'package:techknowlogy/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:techknowlogy/models/news_model.dart';
import 'package:techknowlogy/models/talk_model.dart';
import 'package:techknowlogy/models/utils.dart';

import 'home.dart';
import 'newsletter.dart';

class Newsletter extends StatefulWidget {
  const Newsletter({Key? key}) : super(key: key);

  @override
  _NewsletterState createState() => _NewsletterState();
}

class _NewsletterState extends State<Newsletter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseApi.readNews(),
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
                    const SizedBox(height: 100),
                    latestNews(News.fromJson(snapshot.data!.docs.first.data()!
                        as Map<String, dynamic>)),
                    const SizedBox(
                      height: 50,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: SelectableText(
                        "All newsletters",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 34,
                            color: ceruleanHeading),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: true,
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          News newsfromdata = News.fromJson(data);
                          if (snapshot.data!.docs.first.data().toString() !=
                              data.toString()) {
                            return newsList(newsfromdata);
                          } else {
                            return const SizedBox();
                          }
                        }).toList()),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget latestNews(News newsfromdata) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          String newsID = newsfromdata.id as String;
          Routemaster.of(context).push("/viewnews/$newsID");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              children: [
                Container(
                  height: 150,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [kBoxShadow1],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          Utils.formatDate(newsfromdata.date as DateTime),
                          style: kLightTextStyle.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          'Week in Tech: ' + newsfromdata.title.toString(),
                          style: const TextStyle(fontSize: 23),
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget newsList(News newsfromdata) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          String newsID = newsfromdata.id as String;
          Routemaster.of(context).push("/viewnews/$newsID");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [kBoxShadow1],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          Utils.formatDate(newsfromdata.date as DateTime),
                          style: kLightTextStyle.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          'Week in Tech: ' + newsfromdata.title.toString(),
                          style: const TextStyle(fontSize: 23),
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The ",
                  style: kHeading1Style.copyWith(fontSize: 45),
                ),
                Text(
                  "Newsletter",
                  style: kHeading1Style.copyWith(fontSize: 45, color: cyanDark),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                  "We send out e-mails with tech news every week to keep you informed and up-to-date with the happenings in the world of technology. You can see all of our newsletters over here."),
            )
          ],
        ),
      );
    });
  }
}
