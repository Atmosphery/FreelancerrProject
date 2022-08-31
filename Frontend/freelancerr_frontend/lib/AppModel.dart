// ignore_for_file: file_names, unnecessary_new, unnecessary_this, prefer_collection_literals

import 'User.dart';

class AppModel {
  int? id;
  int? status;
  int? vendorId;
  int? customerId;
  int? jobId;
  String? appointmentDate;

  AppModel(
      {this.id,
      this.status,
      this.vendorId,
      this.customerId,
      this.jobId,
      this.appointmentDate});

  AppModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    vendorId = json['vendorId'];
    customerId = json['customerId'];
    jobId = json['jobId'];
    appointmentDate = json['appointmentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['vendorId'] = this.vendorId;
    data['customerId'] = this.customerId;
    data['jobId'] = this.jobId;
    data['appointmentDate'] = this.appointmentDate;
    return data;
  }

  void updateStatus(int status) {
    this.status = status;
  }
}
