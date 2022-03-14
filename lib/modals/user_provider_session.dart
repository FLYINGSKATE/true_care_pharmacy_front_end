class UserProviderSession {
  String? userId;
  String? name;
  String? speciality;
  String? phoneNumber;
  String? emailId;
  String? password;
  String? typeOfProvider;
  String? dateOfBirth;
  String? gender;

  UserProviderSession(
      {this.userId,
        this.name,
        this.speciality,
        this.phoneNumber,
        this.emailId,
        this.password,
        this.typeOfProvider,
        this.dateOfBirth,
        this.gender});

  UserProviderSession.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    speciality = json['speciality'];
    phoneNumber = json['phone_number'];
    emailId = json['email_id'];
    password = json['password'];
    typeOfProvider = json['type_of_provider'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    data['phone_number'] = this.phoneNumber;
    data['email_id'] = this.emailId;
    data['password'] = this.password;
    data['type_of_provider'] = this.typeOfProvider;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    return data;
  }
}