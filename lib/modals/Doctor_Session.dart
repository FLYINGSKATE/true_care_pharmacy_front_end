class DoctorSession {
  String? userId;
  String? name;
  String? speciality;
  String? phoneNumber;
  String? emailId;
  String? password;

  DoctorSession(
      {this.userId,
        this.name,
        this.speciality,
        this.phoneNumber,
        this.emailId,
        this.password});

  DoctorSession.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    speciality = json['speciality'];
    phoneNumber = json['phone_number'];
    emailId = json['email_id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    data['phone_number'] = this.phoneNumber;
    data['email_id'] = this.emailId;
    data['password'] = this.password;
    return data;
  }
}