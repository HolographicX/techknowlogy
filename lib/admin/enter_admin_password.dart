import 'package:flutter/material.dart';
import 'package:techknowlogy/admin/admin.dart';
import 'package:techknowlogy/constants.dart';
import 'package:techknowlogy/secrets.dart';
import 'package:sizer/sizer.dart';

class EnterAdminPassword extends StatefulWidget {
  const EnterAdminPassword({Key? key}) : super(key: key);

  @override
  _EnterAdminPasswordState createState() => _EnterAdminPasswordState();
}

class _EnterAdminPasswordState extends State<EnterAdminPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (value) {
                    if (value != passwordForAdmin) {
                      return 'Incorrect password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Admin()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: darkblue, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
