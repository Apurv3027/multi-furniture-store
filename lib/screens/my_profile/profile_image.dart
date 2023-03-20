import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  /// Variables
  File? imageFile;

  String? imageUrl;

  /// Get from gallery
  _getFromGallery() async {
    var pickedImage= await ImagePicker().getImage(source: ImageSource.gallery);
    // var file = File(pickedImage!.path);
    if(pickedImage!=null)
    {
      // var snapshot = await FirebaseStorage.instance.ref().child('Profiles').putFile(file);
      // var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(()
      {
        imageFile=File(pickedImage.path);
        // imageUrl = downloadUrl;
      });
    }
  }

  /// Get from camera
  _getFromCamera() async {
    var pickedImage= await ImagePicker().getImage(source: ImageSource.camera);
    // var file = File(pickedImage!.path);
    if(pickedImage!=null)
    {
      // var snapshot = await FirebaseStorage.instance.ref().child('Profiles').putFile(file);
      // var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(()
      {
        imageFile=File(pickedImage.path);
        // imageUrl = downloadUrl;
      });
    }
  }

  // Future<Uri> uploadPic() async {
  //
  //   //Get the file from the image picker and store it
  //   XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   //Create a reference to the location you want to upload to in firebase
  //   Reference reference = FirebaseStorage.instance.ref().child("Profiles/");
  //
  //   //Upload the file to firebase
  //   StorageUploadTask uploadTask = reference.putFile(file);
  //
  //   // Waits till the file is uploaded then stores the download url
  //   Uri location = (await uploadTask.future).downloadUrl;
  //
  //   //returns the download url
  //   return location;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          // color: Colors.greenAccent,
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          // color: Colors.lightGreenAccent,
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: Text("PICK FROM CAMERA"),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircleAvatar(
                      backgroundImage: FileImage(imageFile!),
                      backgroundColor: colorFFCA27,
                      radius: 50,
                    ),
                  ),
        ),
    );
  }
}
