import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:techknowlogy/api/firebase_api.dart';
import 'package:techknowlogy/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:techknowlogy/models/talk_model.dart';
import 'package:url_launcher/url_launcher.dart';

class EditTalk extends StatefulWidget {
  final Talk talkdata;
  const EditTalk({Key? key, required this.talkdata}) : super(key: key);

  @override
  _EditTalkState createState() => _EditTalkState();
}

class _EditTalkState extends State<EditTalk> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final keyinsightsController = TextEditingController();
  final imgController = TextEditingController();
  final recordingController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  String _aestheticColor =
      kAestheticColors[Random().nextInt(kAestheticColors.length)];
  DateTime? date;
  @override
  void initState() {
    titleController.text = widget.talkdata.title.toString();
    keyinsightsController.text = widget.talkdata.keyInsights.toString();
    imgController.text = widget.talkdata.imglink.toString();
    recordingController.text = widget.talkdata.recordingUrl.toString();
    descriptionController.text = widget.talkdata.description.toString();
    _aestheticColor = widget.talkdata.bgHex.toString();
    dateController.text =
        DateFormat.yMMMMd('en_US').format(widget.talkdata.date as DateTime);
    date = widget.talkdata.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Edit Talk',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    // height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: titleController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                        labelText: 'Title',
                      ),
                      validator: (val) => val!.isNotEmpty ? null : 'Required',
                    )),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    // height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: recordingController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                          labelText: 'Recording URL'),
                      validator: (val) => val!.isNotEmpty ? null : 'Required',
                    )),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    // height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: imgController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                          labelText: 'Image URL'),
                      validator: (val) => val!.isNotEmpty ? null : 'Required',
                    )),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    // height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                          labelText: 'Short Description'),
                      maxLines: 2,
                      validator: (val) => val!.isNotEmpty ? null : 'Required',
                    )),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    // height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      controller: keyinsightsController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                          labelText: 'Key Insights'),
                      maxLines: 10,
                    )),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    // height: 30.h,
                    width: 40.w,
                    child: TextFormField(
                      readOnly: true,
                      controller: dateController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                          labelText: 'Date of publication'),
                      onTap: () async {
                        date = await showDatePicker(
                            context: context,
                            initialDate: widget.talkdata.date as DateTime,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        dateController.text =
                            DateFormat.yMMMMd('en_US').format(date as DateTime);
                      },
                    )),
                SizedBox(
                  height: 5.h,
                ),
                const Text('Color'),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _aestheticColor = kAestheticColors[
                              Random().nextInt(kAestheticColors.length)];
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                            decoration: const BoxDecoration(
                                color: cerulean, shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(
                                LineIcons.random,
                                color: primaryColor,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      height: 20.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          color: hexToColor(_aestheticColor).withOpacity(0.3),
                          borderRadius: kBorderRadius),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: cerulean,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 26.h,
                                            width: 17.w,
                                            decoration: BoxDecoration(
                                                color:
                                                    hexToColor(_aestheticColor)
                                                        .withOpacity(0.3),
                                                borderRadius: kBorderRadius),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                            width: 10.w,
                                            child: Image.network(
                                              imgController.text,
                                            ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat.yMMMMd('en_US')
                                                  .format(DateTime.now()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                  color: Colors.black54),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                titleController.text,
                                                style: kHeading1Style.copyWith(
                                                    fontSize: 7.sp),
                                              ),
                                            ),
                                            Text(
                                              descriptionController.text,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 2.5.sp),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Show Preview',
                          style: kHeading1Style.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: cerulean,
                      ),
                      onPressed: () {
                        if (keyinsightsController.text != '') {
                          String data = """<p>""" +
                              keyinsightsController.text +
                              """</p>""";
                          Widget keyInsights = Html(
                              data: data,
                              onLinkTap: (String? url,
                                  RenderContext context,
                                  Map<String, String> attributes,
                                  dom.Element? element) {
                                launch(attributes.entries.first
                                    .value); //launch link, if link is there
                              });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    SizedBox(width: 50.w, child: keyInsights),
                              );
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Show Key Insights Preview',
                          style: kHeading1Style.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Loader.show(context,
                          progressIndicator: const SpinKitPulse(
                            color: darkblue,
                            size: 50,
                          ));
                      final updatedTalk = Talk(
                          title: titleController.text,
                          bgHex: _aestheticColor,
                          imglink: imgController.text,
                          date: date,
                          recordingUrl: recordingController.text,
                          description: descriptionController.text,
                          keyInsights: keyinsightsController.text,
                          id: widget.talkdata.id);
                      print(updatedTalk.toJson());
                      final result = await FirebaseApi.updateTalk(updatedTalk);
                      Loader.hide();
                      // if (false) {
                      if (result != 'error') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Updated talk in database succesfully!',
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: cyanSuccessVarntLight,
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: bittersweet,
                          content: Text(
                              'An error occured while trying to add to database.'),
                        ));
                      }
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      child: Center(
                        child: Text(
                          'Save',
                          style: kHeading1Style.copyWith(
                              fontSize: 7.sp, color: primaryColor),
                        ),
                      ),
                      height: 10.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          color: cyanDark,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(1, 5))
                          ],
                          borderRadius: kBorderRadius),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }
}
