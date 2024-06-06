class AuthModel {
  final int userID;
  final String accessToken;
  final String error;

  AuthModel({required this.userID, required this.accessToken, this.error = "",});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userID: json["id"],
      accessToken: json['access_token'],
    );
  }
}