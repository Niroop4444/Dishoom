class GetLanguagesModel {
  int code;
  String status;
  List<Data> data;

  GetLanguagesModel({this.code, this.status, this.data});

  GetLanguagesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String language;
  String languageURL;
  String languageID;

  Data({this.language, this.languageURL, this.languageID});

  Data.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    languageURL = json['languageURL'];
    languageID = json['languageID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['languageURL'] = this.languageURL;
    data['languageID'] = this.languageID;
    return data;
  }
}
