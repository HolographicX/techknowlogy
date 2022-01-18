import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:line_icons/line_icons.dart';
import 'package:techknowlogy/admin/newsletter/edit_news.dart';
import 'package:techknowlogy/api/firebase_api.dart';
import 'package:techknowlogy/constants.dart';
import 'package:techknowlogy/models/news_model.dart';
import 'package:sizer/sizer.dart';
import 'package:techknowlogy/models/utils.dart';

class ModifyNews extends StatefulWidget {
  const ModifyNews({Key? key}) : super(key: key);

  @override
  _ModifyNewsState createState() => _ModifyNewsState();
}

class _ModifyNewsState extends State<ModifyNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseApi.readNews(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: kLoadingIndicator);
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
              child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                News newsfromdata = News.fromJson(data);
                return Column(
                  children: [
                    Container(
                      width: 50.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          borderRadius: kBorderRadius,
                          color: primaryColor,
                          boxShadow: [kBoxShadow1]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 34.w,
                              height: 20.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    Utils.formatDate(
                                        newsfromdata.date as DateTime),
                                    style: kLightTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(
                                    'Week in Tech: ' +
                                        newsfromdata.title.toString(),
                                    style: const TextStyle(fontSize: 20),
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditNews(
                                              newsdata: newsfromdata)));
                                },
                                icon: const Icon(
                                  LineIcons.edit,
                                )),
                            IconButton(
                                onPressed: () {
                                  _showMyDialog(newsfromdata);
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: bittersweet,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                );
              }).toList()),
            );
          }),
    );
  }

  Future<void> _showMyDialog(News newsdata) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Do you want to delete this news?'),
                Text('Title: ${newsdata.title.toString()}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Loader.show(context, progressIndicator: kLoadingIndicator);
                final result = await FirebaseApi.deleteNews(newsdata);
                if (result.toString() == 'error') {
                  Utils.showErrorSnackBar(
                      context, 'An error occured. Please try again.');
                } else {
                  Utils.showSuccessSnackBar(
                      context, 'Deleted news succesfully!');
                }
                Loader.hide();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
