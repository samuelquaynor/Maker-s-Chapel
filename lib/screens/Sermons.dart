import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/CategoriesModel.dart';
import '../providers/HomeProvider.dart';
import 'CategoryWidget.dart';
import 'MoreWidget.dart';
import 'RecommendedWidget.dart';

class SermonsWidget extends StatelessWidget {
  final HomeProvider? homeProvider;

  const SermonsWidget({
    Key? key,
    required this.homeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CategoriesModel(),
        child: SingleChildScrollView(
          child: Column(children: [
            RecommendedWidget(homeProvider: homeProvider),
            CategoriesWidget(),
            MoreWidget(homeProvider: homeProvider)
          ]),
        ));
  }
}

