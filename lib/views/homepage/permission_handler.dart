import 'package:permission_handler/permission_handler.dart';

Future<bool> requestAppropriateStoragePermission() async {
  if (await Permission.storage.isGranted) return true;

  if (await Permission.storage.request().isGranted) return true;

  // Fallback for Android 13+
  final photos = await Permission.photos.request();
  final videos = await Permission.videos.request();
  final audio = await Permission.audio.request();

  return photos.isGranted || videos.isGranted || audio.isGranted;
}
