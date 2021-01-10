import 'dart:async';
import 'package:flutter/material.dart';

import '../login/authentication_service.dart';
import '../needblood/need_blood.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:telephony/telephony.dart';

class MyHomeApp extends StatelessWidget {
  final Location location = Location();
  PermissionStatus _permissionGranted;

  LocationData locationData;
  StreamSubscription<LocationData> _locationSubscription;
  String _error;

  final Telephony telephony = Telephony.instance;

/*Listen Location Start */
  Future<void> _listenLocation(var phno) async {
    try {
      locationData = await location.getLocation();
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED_NEVER_ASK') {
        Fluttertoast.showToast(msg: 'Please Allow Permission Of Location');
        AppSettings.openAppSettings();
      }
    }
    var linkMsg =
        'Emergency Service Needed To Someone Here Is There Location:-> https://maps.google.com/?q=' +
            locationData.latitude.toString() +
            ',' +
            locationData.longitude.toString();

    final SmsSendStatusListener listener = (SendStatus status) {
      var i = 0;
      if (status == SendStatus.SENT) {
        Fluttertoast.showToast(msg: 'SMS Sent Successfully');
        i = 1;
      } else if (status == SendStatus.DELIVERED) {
        Fluttertoast.showToast(msg: 'SMS Delivered Successfully');
        i = 1;
      } else {
        Fluttertoast.showToast(msg: 'Sorry SMS Not Sent');
      }
    };

    telephony.sendSms(to: phno, message: linkMsg, statusListener: listener);
  }
  /* Listen Location End*/

/* Flat Button Widget Start */
  FlatButton buildFlatButton(
      BuildContext context, String imgAddress, String contactNumber) {
    return FlatButton(
      child: Image.asset(
        imgAddress,
        //height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
      padding: EdgeInsets.all(0.0),
      onPressed: () => _listenLocation(contactNumber),
    );
  }
/* Flat Button Widget End*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Buddy'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              }),
        ],
      ),
      drawer: DrawerWindow(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildFlatButton(
                          context, 'assets/police.png', '+919420416100'),
                      buildFlatButton(
                          context, 'assets/wis.png', '+919420416100'),
                    ],
                  ),
                  Row(
                    children: [
                      buildFlatButton(
                          context, 'assets/fb.png', '+919420416100'),
                      buildFlatButton(
                          context, 'assets/ambulance.png', '+919420416100'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  context.watch<User>().email.toString(),
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.amberAccent,
            ),
          ),
          ListTile(
            title: Text('Need Blood'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NeedBlood(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Close'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
