class User {
  User({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  User.fromJson(dynamic json) {
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
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) =>
      User(
        id: id ?? this.id,
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
