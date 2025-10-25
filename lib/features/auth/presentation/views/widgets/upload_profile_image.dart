import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tharad_tech_task/core/utils/constant.dart';

class UploadProfileImage extends StatefulWidget {
  final Function(File)? onImageSelected;

  const UploadProfileImage({Key? key, this.onImageSelected}) : super(key: key);

  @override
  State<UploadProfileImage> createState() => _UploadProfileImageState();
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  File? _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image_path');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  Future<File> _saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = imagePath.split('/').last;
    final image = File(imagePath);
    final savedImage = await image.copy('${directory.path}/$name');
    return savedImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final savedImage = await _saveImagePermanently(pickedFile.path);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', savedImage.path);

      setState(() {
        _imageFile = savedImage;
      });

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(savedImage);
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('اختيار الصورة', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: AppColors.kPrimaryColor,
              ),
              title: const Text('التقاط من الكاميرا'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.kPrimaryColor,
              ),
              title: const Text('اختيار من المعرض'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showImageSourceDialog,
      child: DottedBorder(
        strokeWidth: 1.5,
        dashPattern: const [6, 3],
        color: AppColors.kPrimaryColor,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 110),
          color: const Color(0xFFF4F7F6),
          child: _imageFile == null
              ? Column(
                  children: [
                    SvgPicture.asset('assets/images/camera.svg'),
                    const SizedBox(height: 6),
                    const Text(
                      "الملفات المسموح بها: JPEG, PNG",
                      style: TextStyle(fontSize: 8, color: Color(0xff998C8C)),
                    ),
                    const Text(
                      "الحد الأقصى للحجم: 5MB",
                      style: TextStyle(fontSize: 8, color: Color(0xff998C8C)),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
        ),
      ),
    );
  }
}
