class AdminModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? dateOfBirth;
  String? gender;
  String? profilePicture;
  bool? isLogin;

  AdminModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dateOfBirth,
    this.profilePicture,
    this.gender,
    this.isLogin,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    dateOfBirth = json['date_of_birth'];
    profilePicture = json['profile_picture'];
    gender = json['gender'];
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['date_of_birth'] = this.dateOfBirth;
    data['profile_picture'] = this.profilePicture;
    data['gender'] = gender;
    data['isLogin'] = isLogin;
    return data;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'date_of_birth': dateOfBirth,
      'profile_picture': profilePicture,
    };
    return map;
  }
}
