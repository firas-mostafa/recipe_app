import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/helpers/theme/theme_helper_extension.dart';
import 'package:recipe_app/logic/user_cubit/user_cubit.dart';
import 'package:recipe_app/presentation/main/logic/index_cubit/index_cubit.dart';
import 'package:recipe_app/helpers/responsive/device_utils.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart';
import 'package:recipe_app/presentation/widgets/svg_icon.dart';

class BottomNavBar extends StatelessWidget {
  final List<String>? icons;
  final List<String>? titles;

  const BottomNavBar(this.icons, this.titles, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.setMineSize(410),
      margin: EdgeInsets.all(context.screenWidth * .01),
      height: DeviceUtils.isMobile(context)
          ? context.setHeight(60)
          : context.setHeight(80),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,

        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withAlpha(80),
            blurRadius: 40,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(50),
        child: ListView.builder(
          itemCount: icons!.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(context.setMineSize(5)),
          itemBuilder: (_, index) => GestureDetector(
            onTap: () {
              context.read<IndexCubit>().changeIndex(index);
              if (index == 2) {
                context.read<UserCubit>().getMe();
              }
            },
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              width: context.watch<IndexCubit>().state.indexValue == index
                  ? context.setMineSize(200)
                  : context.setMineSize(100),
              decoration: BoxDecoration(
                color: context.watch<IndexCubit>().state.indexValue == index
                    ? context.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Center(
                child: context.watch<IndexCubit>().state.indexValue == index
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgIcon(
                            icons![index],
                            color: context.colorScheme.onPrimary,
                          ),
                          SizedBox(width: context.setWidth(5)),
                          Text(
                            titles![index],
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      )
                    : SvgIcon(
                        icons![index],
                        color: context.colorScheme.secondary,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
