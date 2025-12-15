import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/logic/user_cubit/user_cubit.dart';
import 'package:recipe_app/presentation/Auth/widget/auth_base.dart'
    show AuthBase;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/presentation/widgets/custom_text_button.dart'
    show CustomTextButton;
import 'package:recipe_app/presentation/widgets/custom_button.dart'
    show CustomButton;
import 'package:recipe_app/presentation/widgets/custom_text_field.dart'
    show CustomTextField;

import '../../widgets/custom_dialog.dart' show CustomDialog;
import '../../widgets/svg_icon.dart' show SvgIcon;
import '../logic/obscure/obscure_cubit.dart' show ObscureCubit;

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (consumerContext, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacementNamed(context, '');
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              icon: ImageHelper.smile,
              backgroundColor: context.colorScheme.primaryContainer,
              text: "Create Account Success",
              textColor: context.colorScheme.onPrimaryContainer,
            ),
          );
        } else if (state is SignUpFailure) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              icon: ImageHelper.frown,
              backgroundColor: context.colorScheme.errorContainer,
              text: state.errorMessage,
              textColor: context.colorScheme.onErrorContainer,
            ),
          );
        }
      },
      builder: (consumerContext, state) {
        return SafeArea(
          child: Scaffold(
            body: AuthBase(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Account",
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: context.setHeight(20)),
                  CustomTextField(
                    controller: consumerContext.read<UserCubit>().signUpName,
                    textInputAction: TextInputAction.next,
                    focusNode: consumerContext
                        .read<UserCubit>()
                        .signUpNameFocuseNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(
                        consumerContext.read<UserCubit>().signUpEmailFocuseNode,
                      );
                    },
                    text: "Full Name",
                  ),
                  SizedBox(height: context.setHeight(20)),
                  CustomTextField(
                    controller: consumerContext.read<UserCubit>().signUpEmail,
                    text: "Email",
                    textInputAction: TextInputAction.next,
                    focusNode: consumerContext
                        .read<UserCubit>()
                        .signUpEmailFocuseNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(
                        consumerContext
                            .read<UserCubit>()
                            .signUpPasswordFocuseNode,
                      );
                    },
                  ),
                  SizedBox(height: context.setHeight(20)),
                  BlocProvider<ObscureCubit>(
                    create: (context) => ObscureCubit(),
                    child: Builder(
                      builder: (obscureContext) {
                        bool obscure = obscureContext
                            .watch<ObscureCubit>()
                            .state
                            .obscure;
                        return CustomTextField(
                          focusNode: consumerContext
                              .read<UserCubit>()
                              .signUpPasswordFocuseNode,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            if (state is! SignUpLoading) {
                              consumerContext.read<UserCubit>().signUp();
                            }
                          },
                          controller: consumerContext
                              .read<UserCubit>()
                              .signUpPassword,
                          text: 'Password',
                          obscure: obscure,

                          suffix: IconButton(
                            icon: SvgIcon(
                              obscure ? ImageHelper.eye : ImageHelper.eyeOff,
                            ),
                            onPressed: obscureContext
                                .read<ObscureCubit>()
                                .obscureChange,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  Spacer(),

                  state is SignUpLoading
                      ? CircularProgressIndicator()
                      : CustomButton(
                          text: "Register",
                          onTap: consumerContext.read<UserCubit>().signUp,
                        ),

                  SizedBox(height: context.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You already have an account ? ",
                        style: context.textTheme.titleMedium,
                      ),
                      CustomTextButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
