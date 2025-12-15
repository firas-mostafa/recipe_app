import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocConsumer, BlocProvider, ReadContext, WatchContext;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:recipe_app/presentation/widgets/custom_dialog.dart'
    show CustomDialog;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/logic/user_cubit/user_cubit.dart';
import 'package:recipe_app/presentation/Auth/logic/obscure/obscure_cubit.dart'
    show ObscureCubit;
import 'package:recipe_app/presentation/widgets/custom_button.dart'
    show CustomButton;
import 'package:recipe_app/presentation/widgets/custom_text_field.dart'
    show CustomTextField;
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserCubit cubit = context.read<UserCubit>();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: context.setMineSize(60),
        title: Text(
          "Edit Profile",
          style: context.textTheme.headlineMedium!.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          iconSize: context.setMineSize(200),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageHelper.chevronLeft,
            colorFilter: ColorFilter.mode(
              context.colorScheme.onSurface,
              BlendMode.srcIn,
            ),
            width: context.setMineSize(200),
            height: context.setMineSize(200),
          ),
        ),
      ),
      body: Center(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (consumerContext, state) {
            if (state is PatchMeSuccess) {
              cubit.getMe();
              Navigator.pop(context);
              showDialog(
                context: consumerContext,
                builder: (context) => CustomDialog(
                  icon: ImageHelper.smile,
                  backgroundColor: context.colorScheme.primaryContainer,
                  text: "Update Account Success",
                  textColor: context.colorScheme.onPrimaryContainer,
                ),
              );
            } else if (state is PatchMeFailure) {
              showDialog(
                context: consumerContext,
                builder: (context) => CustomDialog(
                  icon: ImageHelper.frown,
                  backgroundColor: context.colorScheme.errorContainer,
                  text: state.errorMessage,
                  textColor: context.colorScheme.onErrorContainer,
                ),
              );
              cubit.getMe();
            }
          },
          builder: (consumerContext, state) {
            final userCubit = consumerContext.read<UserCubit>();
            return SizedBox(
              width: context.setMineSize(700),
              height: context.setMineSize(350),

              child: Center(
                child: state is PatchMeLoading
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.setMineSize(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTextField(
                              controller: userCubit.patchMeName,
                              textInputAction: TextInputAction.next,
                              focusNode: userCubit.patchMeNameFocuseNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(
                                  userCubit.patchMeEmailFocuseNode,
                                );
                              },
                              text: "Full Name",
                            ),
                            CustomTextField(
                              controller: userCubit.patchMeEmail,
                              text: "Email",
                              textInputAction: TextInputAction.next,
                              focusNode: userCubit.patchMeEmailFocuseNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(
                                  userCubit.patchMePasswordFocuseNode,
                                );
                              },
                            ),
                            BlocProvider<ObscureCubit>(
                              create: (context) => ObscureCubit(),
                              child: Builder(
                                builder: (obscureContext) {
                                  bool obscure = obscureContext
                                      .watch<ObscureCubit>()
                                      .state
                                      .obscure;
                                  return CustomTextField(
                                    focusNode:
                                        userCubit.patchMePasswordFocuseNode,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      if (state is! PatchMeLoading) {
                                        userCubit.patchMe();
                                      }
                                    },
                                    controller: userCubit.patchMePassword,
                                    text: 'Password',
                                    obscure: obscure,
                                    suffix: IconButton(
                                      icon: SvgIcon(
                                        obscure
                                            ? ImageHelper.eye
                                            : ImageHelper.eyeOff,
                                      ),
                                      onPressed: obscureContext
                                          .read<ObscureCubit>()
                                          .obscureChange,
                                    ),
                                  );
                                },
                              ),
                            ),
                            CustomButton(
                              text: "Submit",
                              onTap: () {
                                userCubit.patchMe();
                              },
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
