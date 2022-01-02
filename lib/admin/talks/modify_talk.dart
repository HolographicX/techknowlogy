import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:techknowlogy/admin/talks/edit_talk.dart';
import 'package:techknowlogy/api/firebase_api.dart';
import 'package:techknowlogy/constants.dart';
import 'package:techknowlogy/models/talk_model.dart';
import 'package:sizer/sizer.dart';

class ModifyTalk extends StatefulWidget {
  const ModifyTalk({Key? key}) : super(key: key);

  @override
  _ModifyTalkState createState() => _ModifyTalkState();
}

class _ModifyTalkState extends State<ModifyTalk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseApi.readTalks(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: kLoadingIndicator);
            }
            return Center(
              child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Talk talkfromdata = Talk.fromJson(data);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius: kBorderRadius,
                            color: primaryColor,
                            boxShadow: [kBoxShadow1]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 26.h,
                                width: 17.w,
                                decoration: BoxDecoration(
                                    color: Color(int.parse(
                                                talkfromdata.bgHex.toString(),
                                                radix: 16) +
                                            0xFF000000)
                                        .withOpacity(0.3),
                                    borderRadius: kBorderRadius),
                              ),
                              SizedBox(
                                height: 15.h,
                                width: 10.w,
                                child: Image.network(
                                    talkfromdata.imglink.toString()),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 24.h,
                            width: 22.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.yMMMMd('en_US')
                                      .format(talkfromdata.date as DateTime),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Colors.black54),
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    talkfromdata.title.toString(),
                                    style:
                                        kHeading1Style.copyWith(fontSize: 7.sp),
                                  ),
                                ),
                                Text(
                                  talkfromdata.description.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 2.5.sp),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditTalk(talkdata: talkfromdata)));
                              },
                              icon: const Icon(
                                LineIcons.edit,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: bittersweet,
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }).toList()),
            );
          }),
    );
  }
}
