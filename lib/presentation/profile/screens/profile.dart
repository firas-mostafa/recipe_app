import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer, ReadContext;

import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;

import 'package:recipe_app/presentation/profile/widgets/log_out_button.dart'
    show LogOutButton;
import 'package:recipe_app/presentation/profile/widgets/page_header.dart'
    show PageHeader;
import 'package:recipe_app/presentation/profile/widgets/profile_card.dart'
    show ProfileCard;
import 'package:recipe_app/presentation/profile/widgets/profile_tile.dart'
    show CustomProfileTile;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/logic/user_cubit/user_cubit.dart';
import 'package:recipe_app/presentation/widgets/custom_dialog.dart'
    show CustomDialog;

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (consumerContext, state) {
        if (state is GetMeFailure) {
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
        if (state is UploadProfilePicSuccess) {
          context.read<UserCubit>().getMe();
        }
        if (state is UploadProfilePicFailure) {
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
        return state is GetMeLoading || state is UploadProfilePicLoading
            ? SafeArea(
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              )
            : state is GetMeSuccess
            ? Scaffold(
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PageHeader(state.user.profilePic),
                        ProfileCard(
                          title: "Personal",
                          children: [
                            CustomProfileTile(
                              icon: ImageHelper.atSign,
                              text: state.user.name,
                            ),
                            Divider(
                              color: context.colorScheme.surfaceContainerHigh,
                            ),

                            CustomProfileTile(
                              icon: ImageHelper.mail,
                              text: state.user.email,
                            ),
                          ],
                        ),
                        ProfileCard(
                          title: "Help",
                          children: [
                            CustomProfileTile(
                              icon: ImageHelper.messageCircle,
                              text: "Report a bug",
                              sufix: ImageHelper.chevronRight,
                              onSufixTap: () {
                                context.read<UserCubit>().sendEmail();
                              },
                            ),
                            Divider(
                              color: context.colorScheme.surfaceContainerHigh,
                            ),
                            CustomProfileTile(
                              icon: ImageHelper.file,
                              text: "Terms of use",
                              sufix: ImageHelper.chevronRight,
                              onSufixTap: () {
                                Navigator.pushNamed(context, "terms_of_use");
                              },
                            ),
                          ],
                        ),
                        ProfileCard(
                          title: "Account",
                          children: [
                            CustomProfileTile(
                              icon: ImageHelper.edit,
                              text: "Edit Account",
                              sufix: ImageHelper.chevronRight,
                              onSufixTap: () {
                                Navigator.pushNamed(context, "edit_profile");
                              },
                            ),
                          ],
                        ),
                        LogOutButton(),
                        SizedBox(height: context.setMineSize(100)),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(child: Text("Somthing happen"));
      },
    );
  }
}
