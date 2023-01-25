import 'package:flutter/material.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomIconButton({
    Key? key,
    this.icon = Icons.arrow_back_ios,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: CustomColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon).wrapCenter(),
    ).asButton(onPressed);
  }
}
