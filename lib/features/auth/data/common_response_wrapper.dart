class CommonResponseWrapper {
  CommonResponseWrapper({
    this.message,
  });

  CommonResponseWrapper.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  CommonResponseWrapper copyWith({
    String? message,
  }) =>
      CommonResponseWrapper(
        message: message ?? this.message,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;

    return map;
  }
}
