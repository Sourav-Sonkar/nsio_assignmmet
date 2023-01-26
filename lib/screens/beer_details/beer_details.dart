import 'package:api_client/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:nsio_assignment/custom_widgets/custom_icon_button.dart';
import 'package:nsio_assignment/screens/beer_details/widgets/custom_list_tile.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';

class BeerDetails extends StatelessWidget {
  const BeerDetails({
    Key? key,
    required this.beer,
  }) : super(key: key);
  static const String routeName = '/beer_details';
  final Beer beer;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconButton(
                      icon: Icons.arrow_back,
                      onPressed: () {
                        context.pop();
                      },
                    ).paddingLTRB(14, 48, 0, 30),
                    Hero(
                      tag: beer.id ?? '',
                      child: Text(beer.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: CustomColors.text))
                          .paddingLTRB(14, 0, 0, 12),
                    ),
                    Text(beer.tagline ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: CustomColors.textGrey))
                        .paddingLTRB(14, 0, 0, 21),
                  ],
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.containerColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(
                      beer.imageUrl ?? "",
                      height: 200,
                    ).paddingWithSymmetry(horizontal: 30, vertical: 12),
                  ).paddingForOnly(top: MediaQuery.of(context).size.height / 4.5),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: CustomColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        beer.description ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: CustomColors.textGrey),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        "First Brewed",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: CustomColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        beer.firstBrewed ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: CustomColors.textGrey),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        "Getting know your beer better",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: CustomColors.textDark,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 22),
                      // ignore: prefer_const_constructors
                      CustomListTile(
                        attribute1: "ABV",
                        value1: beer.abv.toString(),
                        attribute2: "IBU",
                        value2: beer.ibu.toString(),
                      ),
                      CustomListTile(
                        attribute1: "Target FG",
                        value1: beer.targetFg.toString(),
                        attribute2: "Target OG",
                        value2: beer.targetOg.toString(),
                      ),
                      CustomListTile(
                        attribute1: "EBC",
                        value1: beer.ebc.toString(),
                        attribute2: "SRM",
                        value2: beer.srm.toString(),
                      ),
                      CustomListTile(
                        attribute1: "PH",
                        value1: beer.ph.toString(),
                        attribute2: "Attention Level".toUpperCase(),
                        value2: beer.attenuationLevel.toString(),
                      ),
                    ],
                  ).paddingForOnly(
                      top: MediaQuery.of(context).size.height / 2,
                      left: 14,
                      right: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
