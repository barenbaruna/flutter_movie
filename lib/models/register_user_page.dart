class UserModel {
  String? username;
  String? email;
  bool? isActive;
  bool? isAuthors;
  String? firstName;
  String? lastName;
  String? password1;
  String? password2;

  UserModel(this.username, this.email, this.isActive, this.isAuthors,
      this.firstName, this.lastName, this.password1, this.password2);

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    isActive = json['is_active'];
    isAuthors = json['is_waitress'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    password1 = json['password1'];
    password2 = json['password2'];
  }
}
