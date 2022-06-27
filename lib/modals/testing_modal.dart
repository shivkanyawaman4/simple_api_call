class TestingModal {
  String? status;
  int? error;
  int? success;
  List<Result>? result;

  TestingModal({this.status, this.error, this.success, this.result});

  TestingModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? category;
  String? subcategory;
  String? title;
  String? publish;
  String? description;
  String? imgpath;
  String? deleted;
  String? addedBy;
  String? dt;
  String? type;

  Result(
      {this.id,
      this.category,
      this.subcategory,
      this.title,
      this.publish,
      this.description,
      this.imgpath,
      this.deleted,
      this.addedBy,
      this.dt,
      this.type});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    subcategory = json['subcategory'];
    title = json['title'];
    publish = json['publish'];
    description = json['description'];
    imgpath = json['imgpath'];
    deleted = json['deleted'];
    addedBy = json['added_by'];
    dt = json['dt'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['title'] = this.title;
    data['publish'] = this.publish;
    data['description'] = this.description;
    data['imgpath'] = this.imgpath;
    data['deleted'] = this.deleted;
    data['added_by'] = this.addedBy;
    data['dt'] = this.dt;
    data['type'] = this.type;
    return data;
  }
}
