import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'controller/form_controller.dart';
import 'model/form.dart';
import '../login/authentication_service.dart';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  String genderController;
  var mobilenoController = TextEditingController();
  String bloodgroupController;
  String donatebloodController;
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FeedbackForm feedbackForm;

  _showSnackbar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _submitForm() {
    Fluttertoast.showToast(msg: bloodgroupController);
    // if (bloodgroupController.contains('+')) {
    //   bloodgroupController = bloodgroupController.replaceAll('+', '%2B');
    // }
    bloodgroupController = bloodgroupController.replaceAll('+', '%2B');
    if (_formKey.currentState.validate()) {
      feedbackForm = FeedbackForm(
        nameController.text,
        ageController.text,
        genderController,
        mobilenoController.text,
        bloodgroupController,
        donatebloodController,
        cityController.text,
        stateController.text,
        emailController.text,
        passwordController.text,
      );

      FormController formController = FormController((String res) {
        if (res == FormController.STATUS_SUCESS) {
          Fluttertoast.showToast(msg: 'Feedback Submitted');
        } else {
          Fluttertoast.showToast(msg: 'Error Occured');
        }
      });
      Fluttertoast.showToast(msg: 'Submitting Feedback');

      formController.submitForm(feedbackForm);

      nameController.clear();
      ageController.clear();
      mobilenoController.clear();
      cityController.clear();
      stateController.clear();
      emailController.clear();
      passwordController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Emergency Buddy'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Name
                      TextFormField(
                        controller: nameController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Name',
                          icon: Icon(
                            Icons.info,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Age
                      TextFormField(
                        controller: ageController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid Age';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          hintText: 'Age',
                          icon: Icon(
                            Icons.accessibility,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Gender
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 44.0),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Gender'),
                              items: <String>['Male', 'Female'].map(
                                (val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                },
                              ).toList(),
                              value: genderController,
                              onChanged: (value) {
                                setState(() {
                                  genderController = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),

                      // Mobile Number
                      TextFormField(
                        controller: mobilenoController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid Mobile No';
                          }
                          if (val.length != 10) {
                            return 'Enter valid Password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Mobile Number',
                          icon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Blood Group
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 44.0),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Blood Group'),
                              items: [
                                'A+',
                                'O+',
                                'B+',
                                'AB+',
                                'A-',
                                'O-',
                                'B-',
                                'AB-',
                              ].map(
                                (val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                },
                              ).toList(),
                              value: bloodgroupController,
                              onChanged: (value) {
                                setState(() {
                                  bloodgroupController = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),

                      // Willing to donate blood?
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 44.0),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Willing to donate blood?'),
                              items: <String>['Yes', 'No'].map(
                                (val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                },
                              ).toList(),
                              value: donatebloodController,
                              onChanged: (value) {
                                setState(() {
                                  donatebloodController = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),

                      //city
                      TextFormField(
                        controller: cityController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid City Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'City',
                          hintText: 'City',
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      //state
                      TextFormField(
                        controller: stateController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid State Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'State',
                          hintText: 'State',
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      //email
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid Email Address';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return 'Enter valid Email Address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      //password
                      TextFormField(
                        controller: passwordController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid Password';
                          }
                          if (val.length < 6) {
                            return 'Enter valid Password';
                          }
                          return null;
                        },
                        enableSuggestions: false,
                        autocorrect: false,
                        obscuringCharacter: '*',
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                          icon: Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 23),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shadowColor: Colors.red,
                              elevation: 5,
                            ),
                            onPressed: () async {
                              _formKey.currentState.validate();
                              String x = await context
                                  .read<AuthenticationService>()
                                  .signUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                              Fluttertoast.showToast(
                                msg: x,
                                toastLength: Toast.LENGTH_SHORT,
                              );
                              if (x == 'Signed Up') _submitForm();
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
