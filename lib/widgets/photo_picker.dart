import 'package:app/providers/photos.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

Future<XFile?> pickImage(ImageSource source) async {
  XFile? image = await picker.pickImage(source: source);
  if (image == null) {
    print("No file chosen!");
    return null;
  }

  return image;
}

Future<void> uploadImage({required XFile image, required String path}) async {
  final img = MemoryImage(await image.readAsBytes());
  await PhotoService().uploadPhoto(image: img, path: path);
}

class ImageSourceButton extends StatelessWidget {
  const ImageSourceButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  final String title;
  final Icon icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => onPressed(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, Text(title)]),
        ));
  }
}

Future<dynamic> bottomSheetPhotoSourcePicker(
    {required BuildContext context,
    required String mode,
    String? locationId,
    String? userId,
    Function? onUploadCallback}) {
  Future<String?> _pickAndUpload(ImageSource source) async {
    XFile? photo = await pickImage(source);
    if (photo == null) {
      print("Nothing chosen!");
      return null;
    }

    String path = PhotoService().createPath(
        mode: mode,
        extension: photo.path.split(".").last,
        locationId: locationId,
        userId: userId);

    await uploadImage(image: photo, path: path);

    if (context.mounted) Navigator.of(context).pop();

    if (onUploadCallback != null) {
      onUploadCallback(path);
    }

    return path;
  }

  return bottomSheetBase(
      context: context,
      builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageSourceButton(
                  title: "Gallery",
                  icon: const Icon(Icons.photo),
                  onPressed: () async {
                    String? key = await _pickAndUpload(ImageSource.gallery);
                  }),
              ImageSourceButton(
                  title: "Camera",
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    String? key = await _pickAndUpload(ImageSource.camera);
                  })
            ],
          ));
}