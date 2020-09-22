class GetVideosModel {
  int code;
  String status;
  List<VideoData> data;

  GetVideosModel({this.code, this.status, this.data});

  GetVideosModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<VideoData>();
      json['data'].forEach((v) {
        data.add(new VideoData.fromJson(v));
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

class VideoData {
  String videopath;
  String videoID;
  String cityname;
  String description;
  String userName;
  String profileImageUrl;

  VideoData(
      {this.videopath,
        this.videoID,
        this.cityname,
        this.description,
        this.userName,
        this.profileImageUrl});

  VideoData.fromJson(Map<String, dynamic> json) {
    videopath = json['videopath'];
    videoID = json['videoID'];
    cityname = json['cityname'];
    description = json['description'];
    userName = json['userName'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videopath'] = this.videopath;
    data['videoID'] = this.videoID;
    data['cityname'] = this.cityname;
    data['description'] = this.description;
    data['userName'] = this.userName;
    data['profileImageUrl'] = this.profileImageUrl;
    return data;
  }
}
