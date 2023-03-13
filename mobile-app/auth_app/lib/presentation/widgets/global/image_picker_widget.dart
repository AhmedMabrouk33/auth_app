import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/colors/color_configuration.dart';

class ImagePickerWidget extends StatefulWidget {
  XFile? pickedFile;
  final void Function(XFile?) pickedFunction;
  ImagePickerWidget({
    Key? key,
    required this.pickedFile,
    required this.pickedFunction,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _filePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        XFile? file = await _filePicker.pickImage(source: ImageSource.camera);
        file != null
            ? setState(
                () {
                  widget.pickedFile = file;
                  widget.pickedFunction(file);
                },
              )
            : null;

        print('From Widget picked file Data is');
        print('Run time type ${widget.pickedFile.runtimeType}');
        print('File name is ${widget.pickedFile!.name}');
        print('File Path is ${widget.pickedFile!.path}');
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HexColor('#D9D9D9'),
          image: widget.pickedFile != null
              ? DecorationImage(
                  image: FileImage(
                    File(widget.pickedFile!.path),
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }
}
