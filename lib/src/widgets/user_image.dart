import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vnotifyu/src/utilities/resources/_resources.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';

class UserImage extends StatelessWidget {
  final int? image;
  final String name;
  final Uint8List? newImageData;
  final double radius;
  final bool isUpdate;
  final Function(Uint8List? newImage)? onPickNewImage;
  const UserImage({
    Key? key,
    required this.image,
    this.newImageData,
    required this.name,
    this.radius = 20,
    this.isUpdate = false,
    this.onPickNewImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int? imageLink = image != null ? image : null;
    List<String> nameParts = name.split(' ');
    String nameLetters = '';
    nameParts.forEach((part) {
      if(nameLetters.length < 2) nameLetters+=part[0].toUpperCase();
    });

    final nameWidget = Text(
      nameLetters,
      style: TextStyle(
        fontSize: radius * .8,
        fontWeight: FontWeight.w500
      ),
    );

    dynamic imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: newImageData == null ? imageLink == null ? null : CachedNetworkImage(
        imageUrl: Images.getImage(imageLink),
        errorWidget: (_,__,___) => nameWidget,
        progressIndicatorBuilder: (_,__,downloadProgress) => Loader(progress: downloadProgress.progress),
        fit: BoxFit.cover,
        useOldImageOnUrlChange: true,
      ) : Image.memory(
        newImageData!,
        fit: BoxFit.cover,
      ),
    );

    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          child: imageLink == null ? nameWidget : imageWidget,
        ),
        if(isUpdate) Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async{
              if(onPickNewImage == null) return ;
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image
              );

              if (result != null) {
                onPickNewImage!.call(result.files.single.bytes!);
              }else{
                onPickNewImage!.call(null);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}