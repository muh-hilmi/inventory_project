import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class FullViewImageScreen extends StatelessWidget {
  const FullViewImageScreen({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close)),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child("/${getFileName(imageUrl)}");
                  String url = (await ref.getDownloadURL()).toString();

                  final tempDir = await getTemporaryDirectory();
                  final path = '${tempDir.path}/${ref.name}';

                  await Dio().download(url, path);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Image successfully downloaded')));

                  await GallerySaver.saveImage(path, toDcim: true);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Failed to download image')));
                }
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 3,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  String getFileName(String url) {
    RegExp regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    debugPrint("${Uri.decodeFull(match.group(2)!)}");
    return Uri.decodeFull(match.group(2)!);
  }
}
