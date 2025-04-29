class LoginModel {
  int? id;
  String? token;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  bool? isActive;
  bool? isAuthors;
  String? userBirth;
  String? userAvatar;
  String? userBio;

  LoginModel(this.id, this.token, this.username, this.firstName, this.lastName,
      this.email, this.isActive, this.isAuthors, this.userBirth, this.userAvatar, this.userBio);

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isActive = json['is_active'];
    isAuthors = json['is_authors'];
    userBirth = json['birthday'];
    userAvatar = json['avatar'];
    userBio = json['bio'];
  }
}
