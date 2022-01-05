import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/src/public_ext.dart';

class CsImageUpload extends StatefulWidget {
  final TextEditingController controller;
  final double height;
  final double width;
  final bool convertSize;

  CsImageUpload({this.controller, this.height, this.width, this.convertSize});

  @override
  _CsImageUploadState createState() => _CsImageUploadState();
}

class _CsImageUploadState extends State<CsImageUpload> {
  File file;
  Uint8List orgBytesImage;
  Uint8List newBytesImage;
  String orgBase64 =
      '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';
  String newBase64;

  @override
  Widget build(BuildContext context) {
    if (orgBase64 != null) {
      orgBytesImage = Base64Decoder().convert(orgBase64);
    }
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(children: [
        GestureDetector(
          onTap: () {
            showImageSource(context);
            widget.controller.text = newBase64;
          },
          child: Stack(
            children: [
              Expanded(
                  child: null != newBytesImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.memory(
                            newBytesImage,
                            height: 200,
                            width: width - 80,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey),
                            height: 200,
                            width: width - 80,
                          ),
                        )),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Container(
                  // decoration: BoxDecoration(color: Colors.grey),
                  height: 200,
                  width: width - 80,
                  child: Center(
                      child: Column(
                    children: [
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.cloud_upload_outlined),
                        iconSize: 80,
                      ),
                      Text('UPLADE_IMAGE'),
                      Spacer()
                    ],
                  )),
                ),
              ),
            ],
          ),
        )
      ]),
      // child: Row(
      //
      //   children: [
      //     OutlinedButton(
      //         onPressed: () {
      //           showImageSource(context);
      //           widget.controller.text = newBase64;
      //           // pickImage(context);
      //         },
      //         child: Text('SELECT_IMAGE'.tr())),
      //     orgBase64 != null
      //         ? Image.memory(
      //             orgBytesImage,
      //             height: 160,
      //             width: 160,
      //           )
      //         : Image.memory(
      //             newBytesImage,
      //             height: 160,
      //             width: 160,
      //           ),
      //   ],
      // ),
    );
  }

  Future<XFile> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop(ImageSource.camera);
                        pickImage(ImageSource.camera);
                      },
                      child: Text('CAMERA'.tr())),
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop(ImageSource.gallery);
                        pickImage(ImageSource.gallery);
                      },
                      child: Text('GALLERY'.tr()))
                ],
              ));
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('CAMERA'.tr()),
                    onTap: () {
                      Navigator.of(context).pop(ImageSource.camera);
                      pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('GALLERY'.tr()),
                    onTap: () {
                      Navigator.of(context).pop(ImageSource.gallery);
                      pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ));
    }
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) {
        return;
      }
      final bytes = File(image.path).readAsBytesSync();
      String img64 = await base64Encode(bytes);
      orgBytesImage = null;
      orgBase64 = null;
      setState(() {
        newBase64 = img64;
        newBytesImage = Base64Decoder().convert(img64);
      });
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }
}
