import 'package:flutter/material.dart';

import '../models/Media.dart';
import '../providers/HomeProvider.dart';
import '../utils/my_colors.dart';
import 'HomeSlider.dart';

class RecommendedWidget extends StatelessWidget {
  final HomeProvider? homeProvider;

  const RecommendedWidget({
    Key? key,
    required this.homeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 240,
        child: Column(children: [
          ListTile(
            title: Text('Recommended',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MyColors.primary)),
            // trailing: IconButton(
            //     onPressed: () => null, icon: Icon(Icons.arrow_forward))
          ),
          HomeSlider(homeProvider!.data['sliders'] as List<Media>?)
        ]));
  }
}
