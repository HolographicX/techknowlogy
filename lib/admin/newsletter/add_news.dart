import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:techknowlogy/api/firebase_api.dart';
import 'package:techknowlogy/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:techknowlogy/models/news_model.dart';
import 'package:techknowlogy/models/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dateController = TextEditingController();
  var date = DateTime.now();
  @override
  void initState() {
    dateController.text = DateFormat.yMMMMd('en_US').format(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 13.h),
      child: SingleChildScrollView(
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
                      controller: contentController,
                      decoration: kinputDecorationtextFieldTheme.copyWith(
                          labelText: 'Content'),
                      maxLines: 10,
                      validator: (val) => val!.isNotEmpty ? null : 'Required',
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
                        final datePicker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));

                        date = datePicker as DateTime;
                        dateController.text =
                            DateFormat.yMMMMd('en_US').format(date);
                      },
                    )),
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
                                backgroundColor: primaryColor,
                                content: Container(
                                  width: 40.w,
                                  height: 10.w,
                                  decoration: BoxDecoration(
                                      boxShadow: [kBoxShadow1],
                                      borderRadius: kBorderRadius,
                                      color: primaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          Utils.formatDate(date),
                                          style: kLightTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Week in Tech: ' +
                                              titleController.text,
                                          style: const TextStyle(fontSize: 20),
                                          maxLines: 2,
                                        )
                                      ],
                                    ),
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
                        if (contentController.text != '') {
                          String data =
                              """<p>""" + contentController.text + """</p>""";
                          Widget textContent = Html(
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
                                    SizedBox(width: 50.w, child: textContent),
                              );
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Show text content Preview',
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
                      final result = await FirebaseApi.createNews(News(
                          title: titleController.text,
                          content: contentController.text,
                          date: date));
                      Loader.hide();
                      if (result != 'error') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Added news to database succesfully!',
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: cyanSuccessVarntLight,
                        ));
                        titleController.clear();
                        contentController.clear();
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
                              fontSize: 30, color: primaryColor),
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
