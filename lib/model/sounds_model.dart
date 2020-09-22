class GetSoundsModel {
  int code;
  String status;
  List<Data> data;

  GetSoundsModel({this.code, this.status, this.data});

  GetSoundsModel.fromJson(Map<String, dynamic> json) {
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
  String sound;
  String soundURL;
  String soundID;

  Data({this.sound, this.soundURL, this.soundID});

  Data.fromJson(Map<String, dynamic> json) {
    sound = json['sound'];
    soundURL = json['soundURL'];
    soundID = json['soundID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sound'] = this.sound;
    data['soundURL'] = this.soundURL;
    data['soundID'] = this.soundID;
    return data;
  }
}
