import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:recipe_app/helpers/image/image_helper.dart' show ImageHelper;
import 'package:recipe_app/helpers/responsive/device_utils.dart'
    show DeviceUtils;
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart'
    show SizeHelperExtension;
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart'
    show ThemeHelperExtension;
import 'package:recipe_app/logic/user_cubit/user_cubit.dart' show UserCubit;
import 'package:recipe_app/presentation/widgets/svg_icon.dart' show SvgIcon;

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<UserCubit>().logOut();
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: Container(
        margin: EdgeInsets.all(context.setMineSize(20)),
        padding: EdgeInsets.all(context.setMineSize(10)),
        width: context.setWidth(
          DeviceUtils.valueDecider(
            context,
            onMobile: 450,
            onTablet: 460,
            onDesktop: 300,
          ),
        ),
        height: context.setHeight(65),

        decoration: BoxDecoration(
          color: context.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(context.setMineSize(25)),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.error.withAlpha(30),
              blurRadius: 30,
              offset: Offset(2, 5),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                ImageHelper.logOut,
                color: context.colorScheme.onErrorContainer,
              ),
              SizedBox(width: context.setMineSize(10)),
              Text(
                "Log Out",
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
