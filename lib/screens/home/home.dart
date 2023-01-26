import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nsio_assignment/bloc/home_cubit/home_cubit.dart';
import 'package:nsio_assignment/custom_widgets/custom_icon_button.dart';
import 'package:nsio_assignment/screens/home/widget/beer_contianer.dart';
import 'package:nsio_assignment/screens/profile/profile_screen.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit? _homeCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(context.read<ApiClient>());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeCubit!.getBeers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => _homeCubit!..getBeers(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.background,
          body: RefreshIndicator(
            onRefresh: () async {
              _homeCubit!.getBeers(refresh: true);
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconButton(
                      icon: Icons.person,
                      onPressed: () {
                        context.push(ProfileScreen.routeName);
                      },
                    ).paddingLTRB(14, 48, 0, 30),
                    Text(
                      "Time to Cheers! Choose your beer...",
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: CustomColors.text),
                    ).paddingWithSymmetry(horizontal: 14),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading || state is HomeInitial) {
                          return const CircularProgressIndicator()
                              .wrapCenter()
                              .paddingForAll(50);
                        }
                        if (state is HomeFailed) {
                          return Center(child: Text(state.message));
                        }
                        if (state is HomeLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              return Column(
                                children: [
                                  if (i % 2 == 0)
                                    Row(children: [
                                      if (i < state.beers.length)
                                        BeerContainer(beer: state.beers[i]),
                                      if ((i + 1) < state.beers.length)
                                        const SizedBox(width: 14, height: 0),
                                      if ((i + 1) < state.beers.length)
                                        BeerContainer(beer: state.beers[i + 1]),
                                    ]).paddingWithSymmetry(
                                        horizontal: 14, vertical: 14),
                                  if (i + 1 == state.beers.length)
                                    const CircularProgressIndicator()
                                        .wrapCenter()
                                        .paddingForAll(50)
                                ],
                              );
                            },
                            itemCount: state.beers.length,
                          );
                        }
                        return Container();
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
