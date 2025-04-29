import 'package:flutter_movie/core/session_manager.dart';

String serverAssets = 'http://10.0.2.2:8000/media/film_images';
String profileImage = 'http://10.0.2.2:8000/media/profile_images';
final sessionManager = SessionManager();
// String? avatarFilename = sessionManager.getActiveUserAvatar()?.split('/')?.last;
String? getAvatarFilename() {
  final activeUserAvatar = sessionManager.getActiveUserAvatar();
  return activeUserAvatar?.split('/')?.last ?? '';
}