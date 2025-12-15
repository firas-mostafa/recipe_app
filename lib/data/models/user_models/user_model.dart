import 'package:equatable/equatable.dart' show Equatable;

import 'package:recipe_app/helpers/image/image_helper.dart';
import 'package:recipe_app/core/api/end_ponits.dart' show ApiKey;

class UserModel extends Equatable {
  final String? profilePic;
  final String email;
  final String name;

  const UserModel({this.profilePic, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      profilePic: ImageHelper.fixImageUrl(jsonData[ApiKey.image]),
      email: jsonData[ApiKey.email],
      name: jsonData[ApiKey.name],
    );
  }

  @override
  List<Object?> get props => [profilePic, name, email];
}
