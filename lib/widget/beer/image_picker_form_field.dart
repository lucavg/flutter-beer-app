import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerFormField extends FormField<File> {
  final Function(File)? onImagePicked;

  ImagePickerFormField({
    Key? key,
    FormFieldSetter<File>? onSaved,
    FormFieldValidator<File>? validator,
    File? initialValue,
    AutovalidateMode? autovalidateMode,
    this.onImagePicked,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<File> state) {
            return InkWell(
              onTap: () async {
                final imagePicker = ImagePicker();
                final pickedFile = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 100,
                  maxWidth: 800,
                  maxHeight: 800,
                );
                if (pickedFile != null) {
                  state.didChange(File(pickedFile.path));
                  if (onImagePicked != null) {
                    onImagePicked(File(pickedFile.path));
                  }
                }
              },
              child: state.value == null
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.image),
                          SizedBox(height: 10),
                          Text('Tap to upload an image'),
                        ],
                      ),
                    )
                  : Image.file(
                      state.value!,
                      height: 300,
                    ),
            );
          },
        );
}
