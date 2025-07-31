class LoginReposne {
    int? data;
    bool? status;
    String? message;
    String? todo;

    LoginReposne({
        this.data,
        this.status,
        this.message,
        this.todo,
    });

    factory LoginReposne.fromJson(Map<String, dynamic> json) => LoginReposne(
        data: json["data"],
        status: json["status"],
        message: json["message"],
        todo: json["@TODO"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
        "@TODO": todo,
    };
}
