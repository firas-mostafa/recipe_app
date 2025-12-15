import 'package:flutter/material.dart' show TextEditingController, FocusNode;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:recipe_app/data/models/user_models/user_image_model.dart'
    show UserImageModel;
import 'package:recipe_app/data/repositories/user_repository.dart'
    show UserRepository;
import 'package:recipe_app/data/models/user_models/sign_in_model.dart'
    show SignInModel;
import 'package:recipe_app/data/models/user_models/user_model.dart'
    show UserModel;
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  FocusNode signInEmailFocuseNode = FocusNode();
  FocusNode signInPasswordFocuseNode = FocusNode();
  FocusNode signUpEmailFocuseNode = FocusNode();
  FocusNode signUpPasswordFocuseNode = FocusNode();
  FocusNode signUpNameFocuseNode = FocusNode();
  FocusNode patchMeEmailFocuseNode = FocusNode();
  FocusNode patchMePasswordFocuseNode = FocusNode();
  FocusNode patchMeNameFocuseNode = FocusNode();
  final UserRepository userRepository;

  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up name
  TextEditingController patchMeName = TextEditingController();
  //Sign up email
  TextEditingController patchMeEmail = TextEditingController();
  //Sign up password
  TextEditingController patchMePassword = TextEditingController();
  //Profile Pic
  XFile? profilePic;

  SignInModel? userToken;
  UserCubit(this.userRepository) : super(UserInitial());

  Future<dynamic> signIn() async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
      signInEmail.text,
      signInPassword.text,
    );
    response.fold(
      (errorMessage) => emit(SignInFailure(errorMessage)),
      (signInModel) => emit(SignInSuccess()),
    );
  }

  Future<dynamic> signUp() async {
    emit(SignUpLoading());
    final response = await userRepository.signUp(
      signUpEmail.text,
      signUpName.text,
      signUpPassword.text,
    );
    response.fold(
      (errorMessage) => emit(SignUpFailure(errorMessage)),
      (signInModel) => emit(SignUpSuccess()),
    );
  }

  Future<dynamic> getMe() async {
    emit(GetMeLoading());
    final response = await userRepository.getMe();
    response.fold(
      (errorMessage) => emit(GetMeFailure(errorMessage)),
      (userModel) => emit(GetMeSuccess(userModel)),
    );
  }

  Future<dynamic> patchMe() async {
    emit(PatchMeLoading());
    final response = await userRepository.patchMe(
      patchMeEmail.text,
      patchMePassword.text,
      patchMeName.text,
    );
    response.fold(
      (errorMessage) => emit(PatchMeFailure(errorMessage)),
      (userModel) => emit(PatchMeSuccess(userModel)),
    );
  }

  Future<dynamic> uploadProfilePic(XFile profilePic) async {
    emit(UploadProfilePicLoading());
    final response = await userRepository.uploadProfilePic(profilePic);
    response.fold(
      (errorMessage) => emit(UploadProfilePicFailure(errorMessage)),
      (imageModel) => emit(UploadProfilePicSuccess(imageModel)),
    );
  }

  Future<void> sendEmail() async {
    await userRepository.sendEmail(
      recipientEmail: 'alawiteman@gmail.com',
      subject: 'App Feedback',
      body: 'Hello, I have some feedback about your app...',
    );
  }

  void logOut() {
    userRepository.logOut();
    emit(UserInitial());
  }
}
