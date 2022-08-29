class Job {
  int? id;
  String? title;
  String? description;
  int? userId;
  int? basePrice;

  Job({this.id, this.title, this.description, this.userId, this.basePrice});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    basePrice = json['basePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['basePrice'] = this.basePrice;
    return data;
  }
}
