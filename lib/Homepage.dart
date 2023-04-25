import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  File? imageFile;

  ImagePicker _picker = ImagePicker();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: Column(
        children: [
          Center(
            child: imageFile != null ? Image.file(imageFile!) : Container(color: Colors.green,width: 100.0,height: 100.0),
          ),

          ElevatedButton(onPressed: () async{
            await _picker.pickImage(source: ImageSource.gallery).then((value) async{
               CroppedFile? cropped =  await ImageCropper().cropImage(
                 sourcePath: File(value!.path).path,
                 aspectRatioPresets: [
                   CropAspectRatioPreset.square,
                   CropAspectRatioPreset.ratio3x2,
                   CropAspectRatioPreset.original,
                   CropAspectRatioPreset.ratio4x3,
                   CropAspectRatioPreset.ratio16x9
                 ],
                 uiSettings: [
                   AndroidUiSettings(
                       toolbarTitle: 'Cropper',
                       toolbarColor: Colors.deepOrange,
                       toolbarWidgetColor: Colors.white,
                       initAspectRatio: CropAspectRatioPreset.original,
                       lockAspectRatio: false),
                   IOSUiSettings(
                     title: 'Cropper',
                   ),
                   WebUiSettings(
                     context: context,
                   ),
                 ],
               );

               if(cropped!=null)
                 {
                   setState(() {
                     imageFile = File(cropped!.path);
                   });
                 }

             });

          }, child: Text("Gallery")),
        ],
      ),

    );
  }




}
