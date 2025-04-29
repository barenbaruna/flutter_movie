import 'package:hive_flutter/hive_flutter.dart';

class SessionManager {
  final Box box = Hive.box('session');

  void setSession(
      int id, String token, String email, String firstName, String lastName,
      {Map<String, String?>? userData}) {
    // Store data to session
    box.put(AppKey.idKey, id);
    box.put(AppKey.tokenKey, token);
    box.put(AppKey.emailKey, email);
    box.put(AppKey.firstNameKey, firstName);
    box.put(AppKey.lastNameKey, lastName);
    if (userData != null) {
      box.put(AppKey.userBirthKey, userData['userBirth'] ?? '');
      box.put(AppKey.userAvatarKey, userData['userAvatar'] ?? '');
      box.put(AppKey.userBioKey, userData['userBio'] ?? '');
    }
  }

  int? getActiveId() => box.get(AppKey.idKey);
  String? getActiveToken() => box.get(AppKey.tokenKey);
  String? getActiveEmail() => box.get(AppKey.emailKey);
  String? getActiveFirstName() => box.get(AppKey.firstNameKey);
  String? getActiveLastName() => box.get(AppKey.lastNameKey);
  String? getActiveUserBirth() => box.get(AppKey.userBirthKey);
  String? getActiveUserAvatar() => box.get(AppKey.userAvatarKey);
  String? getActiveUserBio() => box.get(AppKey.userBioKey);

  bool anyActiveSession() {
    int? activeId = getActiveId();
    String? activeToken = getActiveToken();
    String? activeEmail = getActiveEmail();
    String? activeFirstName = getActiveFirstName();
    String? activeLastName = getActiveLastName();
    String? activeUserBirth = getActiveUserBirth();
    String? activeUserAvatar = getActiveUserAvatar();
    String? activeUserBio = getActiveUserBio();
    return activeId != null &&
        activeToken != null &&
        activeEmail != null &&
        activeFirstName != null &&
        activeLastName != null &&
        activeUserBirth != null &&
        activeUserAvatar != null &&
        activeUserBio != null;
  }

  void signOut() {
    box.delete(AppKey.idKey);
    box.delete(AppKey.tokenKey);
    box.delete(AppKey.emailKey);
    box.delete(AppKey.firstNameKey);
    box.delete(AppKey.lastNameKey);
    box.delete(AppKey.userBirthKey);
    box.delete(AppKey.userAvatarKey);
    box.delete(AppKey.userBioKey);
  }
}

class AppKey {
  static const String idKey = 'ID_KEY';
  static const String tokenKey = 'TOKEN_KEY';
  static const String emailKey = 'EMAIL_KEY';
  static const String firstNameKey = 'FIRSTNAME_KEY';
  static const String lastNameKey = 'LASTNAME_KEY';
  static const String userBirthKey = 'USERBIRTH_KEY';
  static const String userAvatarKey = 'USERAVATAR_KEY';
  static const String userBioKey = 'USERBIO_KEY';
}
