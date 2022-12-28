import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/container.dart';
import 'package:image_picker/image_picker.dart';

class CameraEx extends StatefulWidget {
  const CameraEx({super.key});

  @override
  State<CameraEx> createState() => _CameraExState();
}

class _CameraExState extends State<CameraEx> {
  File? _image;
  final picker = ImagePicker();
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    setState(() {
      _image = File(image!.path);
    });
  }
  Widget showImage(){
    return Container(
      color:  const Color(0xffd0cece),
      width:  MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Container(
        child: _image ==null ? const Text('No image selected.') : Image.file(File(_image!.path)),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
    );
    return Scaffold(
      backgroundColor: const Color(0xfff4f3f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25.0,),
          showImage(),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //카메라 촬영 버튼
              FloatingActionButton(
                tooltip: 'pick Image',
                onPressed: (){
                  getImage(ImageSource.camera);
                },
                child:  const Icon(Icons.add_a_photo)),
              //  갤러리에서 이미지 가져오는 것            
               FloatingActionButton(
                tooltip: 'pick Image',
                onPressed: (){
                  getImage(ImageSource.gallery);
                },
                child: const Icon(Icons.wallpaper)),
            ],
          )
        ]),
    );
  }
}