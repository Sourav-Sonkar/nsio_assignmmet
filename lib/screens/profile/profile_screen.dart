import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nsio_assignment/bloc/auth_cubit/auth_cubit.dart';
import 'package:nsio_assignment/custom_widgets/custom_icon_button.dart';
import 'package:nsio_assignment/screens/login/login.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';
import 'package:user_preferences_client/user_preferences_client.dart';

import '../../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.pureWhite,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: CustomColors.background,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      context.pop();
                    },
                  ).paddingLTRB(14, 48, 0, 30),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FutureBuilder(
                    future: UserPreferences.getUserPhoto(),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(snapShot.data.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return const CircularProgressIndicator().wrapCenter();
                    },
                  ).paddingForOnly(top: MediaQuery.of(context).size.height / 4),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: CustomColors.textGrey),
                      ).paddingForOnly(top: 40),
                      FutureBuilder(
                        future: UserPreferences.getUserName(),
                        builder: (context, snapShot) {
                          if (snapShot.connectionState == ConnectionState.done) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(11, 28, 0, 28),
                              decoration: BoxDecoration(
                                color: CustomColors.containerColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                snapShot.data.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: CustomColors.textDark),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ).paddingWithSymmetry(vertical: 10),
                      Text(
                        "Email",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: CustomColors.textGrey),
                      ).paddingForOnly(top: 10),
                      FutureBuilder(
                        future: UserPreferences.getUserEmail(),
                        builder: (context, snapShot) {
                          if (snapShot.connectionState == ConnectionState.done) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(11, 28, 0, 28),
                              decoration: BoxDecoration(
                                color: CustomColors.containerColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                snapShot.data.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: CustomColors.textDark),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ).paddingWithSymmetry(vertical: 10),
                      const SizedBox(height: 76),
                      Container(
                        width: double.infinity,
                        height: 75,
                        decoration: BoxDecoration(
                          color: CustomColors.danger,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Logout",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: CustomColors.pureWhite),
                        ).wrapCenter(),
                      ).asButton(() {
                        context.read<AuthCubit>().logout();
                        context.go(LoginScreen.routeName);
                      }).paddingForOnly(bottom: 30),
                    ],
                  ).paddingForOnly(
                    top: MediaQuery.of(context).size.height / 2,
                    left: 14,
                    right: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
