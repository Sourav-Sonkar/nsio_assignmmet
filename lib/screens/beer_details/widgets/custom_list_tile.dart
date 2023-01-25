import 'package:flutter/material.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';

class CustomListTile extends StatelessWidget {
  final String attribute1;
  final String value1;
  final String attribute2;
  final String value2;

  const CustomListTile({
    Key? key,
    required this.attribute1,
    required this.value1,
    required this.attribute2,
    required this.value2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SingleTileDesign(attribute1: attribute1, value1: value1),
        SingleTileDesign(attribute1: attribute2, value1: value2),
      ],
    );
  }
}

class SingleTileDesign extends StatelessWidget {
  const SingleTileDesign({
    Key? key,
    required this.attribute1,
    required this.value1,
  }) : super(key: key);

  final String attribute1;
  final String value1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          decoration: BoxDecoration(
            color: CustomColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset("assets/images/cheers.png")
              .paddingWithSymmetry(horizontal: 8, vertical: 8),
        ),
        title: Text(attribute1,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: CustomColors.textDark)),
        subtitle: Text(
          value1,
          style: Theme.of(context).textTheme.headline1?.copyWith(
              color: CustomColors.textGrey, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
