import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/presentation/widgets/custom_dialog.dart'
    show CustomDialog;

import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/logic/user_cubit/user_cubit.dart';
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;
import 'package:recipe_app/presentation/Auth/widget/auth_base.dart'
    show AuthBase;
import 'package:recipe_app/presentation/Auth/logic/obscure/obscure_cubit.dart'
    show ObscureCubit;
import 'package:recipe_app/presentation/widgets/custom_text_button.dart'
    show CustomTextButton;
import 'package:recipe_app/presentation/widgets/custom_button.dart'
    show CustomButton;
import 'package:recipe_app/presentation/widgets/custom_text_field.dart'
    show CustomTextField;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (consumerContext, state) {
        if (state is SignInSuccess) {
          Navigator.pushReplacementNamed(context, '');
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              icon: ImageHelper.smile,
              backgroundColor: context.colorScheme.primaryContainer,
              text: "Login Success",
              textColor: context.colorScheme.onPrimaryContainer,
            ),
          );
        } else if (state is SignInFailure) {
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
                    "Hello Again !",
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                  //Email Field
                  SizedBox(height: context.setHeight(20)),
                  CustomTextField(
                    controller: consumerContext.watch<UserCubit>().signInEmail,
                    text: "Email",
                    textInputAction: TextInputAction.next,
                    focusNode: consumerContext
                        .read<UserCubit>()
                        .signInEmailFocuseNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(
                        consumerContext
                            .read<UserCubit>()
                            .signInPasswordFocuseNode,
                      );
                    },
                  ),
                  //password field
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
                          controller: consumerContext
                              .watch<UserCubit>()
                              .signInPassword,
                          text: 'Password',
                          obscure: obscure,
                          focusNode: consumerContext
                              .read<UserCubit>()
                              .signInPasswordFocuseNode,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            consumerContext.read<UserCubit>().signIn();
                          },
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
                  //Forget Password ?
                  SizedBox(height: context.setHeight(14)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          'create_account',
                        );
                      },
                      text: "Forget Password",
                    ),
                  ),
                  Spacer(),
                  //Login button
                  state is SignInLoading
                      ? CircularProgressIndicator()
                      : CustomButton(
                          text: "Login",
                          onTap: consumerContext.read<UserCubit>().signIn,
                        ),

                  //not a member ? Register Now
                  SizedBox(height: context.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member ? ",
                        style: context.textTheme.titleMedium,
                      ),
                      CustomTextButton(
                        onTap: () {
                          Navigator.pushNamed(context, 'create_account');
                        },
                        text: 'Register Now ',
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
