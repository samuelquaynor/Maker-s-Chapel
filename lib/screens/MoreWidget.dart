import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Media.dart';
import '../models/Radios.dart';
import '../providers/AudioPlayerModel.dart';
import '../providers/HomeProvider.dart';
import '../utils/my_colors.dart';
import 'AudioScreen.dart';
import 'VideoScreen.dart';

class MoreWidget extends StatelessWidget {
  final HomeProvider? homeProvider;
  const MoreWidget({
    Key? key,
      required this.homeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        child: Column(children: [
          ListTile(
              title: Text('More',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primary))),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                      child: Column(children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 110.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/radio.jpg"),
                                        fit: BoxFit.cover)))),
                        SizedBox(height: 7.0),
                        Container(
                            alignment: Alignment.center,
                            child: Text('Radio',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                                maxLines: 1,
                                textAlign: TextAlign.center))
                      ]),
                      onTap: () {
                        Radios radios = homeProvider!.data['radios'] as Radios;
                        Media media = new Media(
                            id: radios.id,
                            title: radios.title,
                            coverPhoto: radios.coverPhoto,
                            streamUrl: radios.streamUrl);
                        Provider.of<AudioPlayerModel>(context, listen: false)
                            .prepareradioplayer(media);
                      })),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                      child: Column(children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 110.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/messages.jpg"),
                                        fit: BoxFit.cover)))),
                        SizedBox(height: 7.0),
                        Container(
                            alignment: Alignment.center,
                            child: Text('Videos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                                maxLines: 1,
                                textAlign: TextAlign.center))
                      ]),
                      onTap: () {
                        Navigator.of(context).pushNamed(VideoScreen.routeName);
                      })),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                      child: Column(children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 110.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/sermons.jpg"),
                                        fit: BoxFit.cover)))),
                        SizedBox(height: 7.0),
                        Container(
                            alignment: Alignment.center,
                            child: Text('Audios',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                                maxLines: 1,
                                textAlign: TextAlign.center))
                      ]),
                      onTap: () {
                        Navigator.of(context).pushNamed(AudioScreen.routeName);
                      }))
            ]),
          )
        ]));
  }
}
