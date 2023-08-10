import 'package:app/model/generated.dart';
import 'package:app/provider/generated/locations_provider.dart';
import 'package:app/provider/generated/users_provider.dart';
import 'package:app/provider/photos.dart';
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

Future<bool> uploadImage({required XFile image, required String path}) async {
  final img = MemoryImage(await image.readAsBytes());
  return await PhotoManager.instance.setPhoto(img, path);
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

    const allowedExtensions = ["jpg", "jpeg", "png"];
    final extension = photo.path.split(".").last;

    String ext = allowedExtensions
        .firstWhere((e) => extension.toLowerCase() == e, orElse: () => "");
    if (ext == "") {
      print("Not a valid file name. Needs an extension!");
      return null;
    }

    String path = PhotoService.createPath(
        mode: mode, extension: ext, locationId: locationId, userId: userId);

    final photoData = PhotoUrl(url: path);
    try {
      if (mode == "location") {
        await LocationsProvider.addPhoto(
            locationId: locationId!, data: photoData);
      } else {
        await UsersProvider.createProfilePhoto(data: photoData);
      }
    } catch (e) {
      print("Creation in backend failed with error $e! Not uploading image...");
      return null;
    }

    final uploaded = await uploadImage(image: photo, path: path);

    // if the photo could not be uploaded, the info is deleted in the backend too
    if (!uploaded) {
      if (mode == "location") {
        await LocationsProvider.removePhoto(
            locationId: locationId!, data: photoData);
      } else {
        await UsersProvider.deleteProfilePhoto();
      }
    }

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
                    await _pickAndUpload(ImageSource.gallery);
                  }),
              ImageSourceButton(
                  title: "Camera",
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    await _pickAndUpload(ImageSource.camera);
                  })
            ],
          ));
}
