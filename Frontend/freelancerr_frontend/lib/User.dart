// ignore_for_file: unused_import, depend_on_referenced_packages, unnecessary_this, prefer_collection_literals, unnecessary_new

class User {
  String? id;
  String? name;
  String? phonenumber;
  String? email;
  String? address;
  String? password;
  String? bio;
  List<String>? appointments;
  bool? vender;
  String? currentMessage;

  User(
      {this.id,
      this.name,
      this.phonenumber,
      this.email,
      this.address,
      this.password,
      this.bio,
      this.appointments,
      this.vender,
      this.currentMessage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
    bio = json['bio'];
    if (json['appointments'] != null) {
      appointments = <String>[];
      json['appointments'].forEach((v) {
        appointments!.add('test');
      });
    }
    vender = json['vender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['password'] = this.password;
    data['bio'] = this.bio;
    if (this.appointments != null) {
      //data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    data['vender'] = this.vender;
    return data;
  }
}
