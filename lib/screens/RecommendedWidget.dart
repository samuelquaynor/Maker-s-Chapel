import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Media.dart';
import '../providers/AppStateManager.dart';
import '../providers/HomeProvider.dart';
import '../utils/my_colors.dart';
import 'HomeSlider.dart';

class RecommendedWidget extends StatefulWidget {
  final HomeProvider? homeProvider;

  const RecommendedWidget({
    Key? key,
    required this.homeProvider,
  }) : super(key: key);

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  late AppStateManager appManager;
  @override
  Widget build(BuildContext context) {
    appManager = Provider.of<AppStateManager>(context);
    return Container(
        width: double.infinity,
        height: 240,
        child: Column(children: [
          ListTile(
            title: Text('Recommended',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: appManager.preferredTheme == 1
                      ? Colors.white
                      : MyColors.primary)),
            // trailing: IconButton(
            //     onPressed: () => null, icon: Icon(Icons.arrow_forward))
          ),
          HomeSlider(widget.homeProvider!.data['sliders'] as List<Media>?)
        ]));
  }
}
