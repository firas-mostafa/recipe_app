import 'package:dartz/dartz.dart' show Left, Right, Either;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:recipe_app/core/api/end_ponits.dart';
import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;
import 'package:recipe_app/core/api/api_consumer.dart' show ApiConsumer;

import 'package:recipe_app/core/errors/exceptions.dart' show ServerException;
import 'package:recipe_app/core/functions/upload_image_to_api.dart'
    show uploadImageToAPI;
import '../models/user_models/sign_in_model.dart' show SignInModel;
import '../models/user_models/user_image_model.dart' show UserImageModel;
import '../models/user_models/user_model.dart' show UserModel;
import 'package:recipe_app/helpers/cache/cache_helper.dart' show CacheHelper;

class UserRepository {
  final ApiConsumer apiConsumer;

  UserRepository(this.apiConsumer);
  Future<Either<String, SignInModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.token,
        isFromData: true,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      final SignInModel user = SignInModel.fromJson(response);
      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignInModel>> signUp(
    String email,
    String name,
    String password,
  ) async {
    try {
      await apiConsumer.post(
        EndPoint.createUser,
        data: {
          ApiKey.name: name,
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );
      final response = await apiConsumer.post(
        EndPoint.token,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      final SignInModel user = SignInModel.fromJson(response);
      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getMe() async {
    try {
      final response = await apiConsumer.get(EndPoint.me);
      final UserModel user = UserModel.fromJson(response);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> patchMe(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await apiConsumer.patch(
        EndPoint.me,
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.name: name,
        },
      );
      final UserModel user = UserModel.fromJson(response);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserImageModel>> uploadProfilePic(
    XFile profilePic,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.uploadUserImage,
        isFromData: true,
        data: {ApiKey.image: await uploadImageToAPI(profilePic)},
      );
      final UserImageModel userImageModel = UserImageModel.fromJson(response);
      return Right(userImageModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<void> sendEmail({
    required String recipientEmail,
    String? subject,
    String? body,
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }

  void logOut() {
    CacheHelper().clearData(key: ApiKey.token);
  }
}
