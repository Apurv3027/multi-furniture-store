import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/views/buyers/main_screen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 30.0,
          ),
          onPressed: () {
            Get.offAll(Home_ScreenEx());
          },
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'CONTACT',
                style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Material(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  'Our address',
                  style: TextStyle(
                      fontSize:20.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  '1412 Steiner Street, San Francisco, CA, 94115',
                  style: TextStyle(
                      fontSize:16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: ListTile(
                leading: Text(
                  'E-mail us',
                  style: TextStyle(
                      fontSize:20.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: Text(
                  'office@shopertino.com',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                  'Our business hour are Mon - Fri, 10am - 6pm, PST'
              ),
            ),
            SizedBox(height: 20.0),
            Material(
              color: Colors.white,
              child: ListTile(
                title: Center(
                  child: Text(
                    'Call Us',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
