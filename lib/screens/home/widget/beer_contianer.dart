import 'package:api_client/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nsio_assignment/screens/beer_details/beer_details.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';

class BeerContainer extends StatelessWidget {
  final Beer beer;
  const BeerContainer({
    Key? key,
    required this.beer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bottle_background.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Image.network(
                    beer.imageUrl ?? "",
                    height: 100,
                  ).paddingForOnly(top: 12, bottom: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.background,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "First Brewed: ${beer.firstBrewed}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).paddingWithSymmetry(horizontal: 7, vertical: 3),
                  ),
                ],
              ).paddingWithSymmetry(horizontal: 14, vertical: 12)),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: CustomColors.pureWhite,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: beer.id ?? "",
                  child: Text(
                    beer.name ?? "",
                    softWrap: true,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Text(
                  beer.description ?? "",
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: CustomColors.textGrey),
                ).paddingWithSymmetry(vertical: 4),
                Row(children: [
                  BeerAttributes(attribute: "ABV", value: beer.abv.toString()),
                  const SizedBox(width: 16),
                  BeerAttributes(attribute: "IBU", value: beer.ibu.toString()),
                ])
              ],
            ).paddingWithSymmetry(horizontal: 14, vertical: 12),
          ),
        ],
      ).asButton(() {
        context.push(BeerDetails.routeName, extra: beer);
      }),
    );
  }
}

class BeerAttributes extends StatelessWidget {
  final String attribute;
  final String value;
  const BeerAttributes({
    Key? key,
    required this.attribute,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attribute,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CustomColors.textDark,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CustomColors.textGrey,
              ),
        ),
      ],
    );
  }
}
