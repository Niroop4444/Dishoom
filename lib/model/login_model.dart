class LoginModel {
  Data data;
  int code;
  String status;

  LoginModel({this.data, this.code, this.status});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      code: json['code'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String customerUUID;
  bool isNewUser;
  Token token;
  String userName;

  Data({this.customerUUID, this.isNewUser, this.token, this.userName});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      customerUUID: json['customerUUID'],
      isNewUser: json['isNewUser'],
      token: json['token'] != null ? Token.fromJson(json['token']) : null,
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerUUID'] = this.customerUUID;
    data['isNewUser'] = this.isNewUser;
    data['userName'] = this.userName;
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    return data;
  }
}

class Token {
  String accesstoken;
  int expirationperiod;
  String refreshtoken;

  Token({this.accesstoken, this.expirationperiod, this.refreshtoken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accesstoken: json['accesstoken'],
      expirationperiod: json['expirationperiod'],
      refreshtoken: json['refreshtoken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accesstoken'] = this.accesstoken;
    data['expirationperiod'] = this.expirationperiod;
    data['refreshtoken'] = this.refreshtoken;
    return data;
  }
}