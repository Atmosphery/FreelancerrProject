class User {
  int? id;

  String? name;
  String? phonenumber;
  String? email;
  String? address;
  String? password;
  String? bio;
  bool? isVendor = false;
  //store the appointment Id's in a list
  List<String>? appointments;

  User(
      {this.address,
      this.id,
      this.name,
      this.phonenumber,
      this.email,
      this.password,
      this.appointments,
      this.bio,
      this.isVendor});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      id: json['id'] as int,
      phonenumber: json['phonenumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      bio: json['bio'] as String,
      appointments: json['appointments'] as List<String>,
      isVendor: json['isVendor'] as bool,
    );
  }

  void addAppointment(String app) {
    appointments!.add(app);
  }
}
