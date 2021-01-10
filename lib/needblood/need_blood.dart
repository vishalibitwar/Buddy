import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class NeedBlood extends StatefulWidget {
/*Retrive Data Start*/
  @override
  _NeedBloodState createState() => _NeedBloodState();
}

class _NeedBloodState extends State<NeedBlood> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final String url =
      'https://script.google.com/macros/s/AKfycbxOLElujQcy1-ZUer1KgEvK16gkTLUqYftApjNCM_IRTL3HSuDk/exec?id=1W7HHGY9_J5eeNrciuO3WGj8u50NpnUp6r0zLYn_rF4E&sheet=Sheet1';

  List data;

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Sheet1'];
    });
    pr.hide();
    return 'Success';
  }

  @override
  void initState() {
    // getJsonData();
    Fluttertoast.showToast(msg: 'Click On Blood Button To show List Of Donors');
    super.initState();
  }

  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Emergency Buddy'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (ctx, index) {
                return data == null
                    ? Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      )
                    : FlatButton(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data[index]['Name'].toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(data[index]['Email'].toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    data[index]['Blood_Group'].toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(data[index]['Mobile_Number'].toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detailes(data[index]),
                            ),
                          );
                        });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 100.0,
        height: 100.0,
        child: new RawMaterialButton(
          shape: new CircleBorder(),
          fillColor: Colors.red,
          elevation: 0.0,
          child: Text(
            'BLOOD',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            pr.show();
            getJsonData();
          },
        ),
      ),
    );
  }
}

class Detailes extends StatelessWidget {
  final Map data;
  Detailes(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Buddy'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContainer('Name:', data['Name'].toString()),
            buildContainer('Age: ', data['Age'].toString()),
            buildContainer('Gender: ', data['Gender'].toString()),
            buildContainer('Mobile Number: ', data['Mobile_Number'].toString()),
            buildContainer('Blood Group: ', data['Blood_Group'].toString()),
            buildContainer('City: ', data['City'].toString()),
            buildContainer('State: ', data['State'].toString()),
            buildContainer('Email: ', data['Email'].toString()),
          ],
        ),
      ),
    );
  }

  Container buildContainer(String key, String value) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ]),
      child: Text(
        key + value,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
