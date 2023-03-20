import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/colors.dart';

class ReferFriends extends StatefulWidget {
  const ReferFriends({Key? key}) : super(key: key);

  @override
  State<ReferFriends> createState() => _ReferFriendsState();
}

class _ReferFriendsState extends State<ReferFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: Text(
          "Refer A Friends",
          style: TextStyle(
            fontSize: 18,
            color: colorFFFFFF,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Refer A Friends',
              style:
              TextStyle(fontSize: 50, color: color5254A8, shadows: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(-3, -3),
                )
              ]),
            ),
            Text(
              'Coming Soon ...',
              style:
              TextStyle(fontSize: 40, color: color5254A8, shadows: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(-3, -3),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
