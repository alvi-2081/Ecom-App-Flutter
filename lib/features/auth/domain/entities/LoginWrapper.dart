/// message : "User loggedin successfully"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjY1NDI3ODJjZDliNjU1Zjg0NGU1Y2JjIiwiZW1haWwiOiJhYmR1bGxAZ21haWwuY29tIn0sImlhdCI6MTcxNjk2MTEwNCwiZXhwIjoxNzE5NTUzMTA0fQ.LuCUF_hh14tKh_WJVfFYzlxt5DVrCxRpQVAhzfIe6ho"
/// data : {"_id":"66542782cd9b655f844e5cbc","name":"Abdull","email":"abdull@gmail.com","createdAt":"2024-05-27T06:26:10.524Z","updatedAt":"2024-05-27T06:26:10.524Z","__v":0}

class LoginWrapper {
  LoginWrapper({
      this.message, 
      this.token, 
      this.data,});

  LoginWrapper.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  String? token;
  Data? data;
LoginWrapper copyWith({  String? message,
  String? token,
  Data? data,
}) => LoginWrapper(  message: message ?? this.message,
  token: token ?? this.token,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// _id : "66542782cd9b655f844e5cbc"
/// name : "Abdull"
/// email : "abdull@gmail.com"
/// createdAt : "2024-05-27T06:26:10.524Z"
/// updatedAt : "2024-05-27T06:26:10.524Z"
/// __v : 0

class Data {
  Data({
      this.id, 
      this.name, 
      this.email, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? v;
Data copyWith({  String? id,
  String? name,
  String? email,
  String? createdAt,
  String? updatedAt,
  int? v,
}) => Data(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}