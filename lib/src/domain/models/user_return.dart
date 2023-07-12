class UserReturn {
  bool success;
  String? errors;
  String? msg;
  String? payload;

  UserReturn({
    required this.success,
    this.errors,
    this.msg,
    this.payload,
  });

  factory UserReturn.empty(){
    return UserReturn(
        success: false,
        errors: null,
        msg: null,
        payload: null,
    );
  }

  factory UserReturn.fromJson(Map<String, dynamic> json) {
    return UserReturn(
        success: json["success"] ?? false,
        errors: json["errors"] ?? '',
        msg: json["msg"],
        payload: json["payload"]
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['errors'] = errors;
    data['msg'] = msg;
    data['payload'] = payload;
    return data;
  }
}
