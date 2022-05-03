import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required String thumbnailUrl,
  }) : super(id: id, name: name, email: email, thumbnailUrl: thumbnailUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final loginMap = json['login'] as Map<String, dynamic>;
    final nameMap = json['name'] as Map<String, dynamic>;
    final pictureMap = json['picture'] as Map<String, dynamic>;

    return UserModel(
      id: loginMap['uuid'] as String,
      name: '${nameMap["first"]} ${nameMap["last"]}',
      email: json['email'] as String,
      thumbnailUrl: pictureMap['thumbnail'] as String,
    );
  }
}
