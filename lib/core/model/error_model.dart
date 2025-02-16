class ErrorModel {
  String? errorMessage;

  ErrorModel({
    this.errorMessage,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        errorMessage: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": errorMessage,
      };

  fromJson(Map<String, dynamic> json) {
    return ErrorModel.fromJson(json);
  }
}
