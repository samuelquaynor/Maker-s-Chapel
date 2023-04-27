import 'package:churchapp_flutter/models/LiveStreams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../audio_player/miniPlayer.dart';
import '../i18n/strings.g.dart';
import '../livetvplayer/LivestreamsPlayer.dart';
import '../providers/AppStateManager.dart';
import '../providers/HomeProvider.dart';
import '../utils/my_colors.dart';
import 'InboxListScreen.dart';
import 'NoitemScreen.dart';
import 'SearchScreen.dart';
import 'Sermons.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key? key,
    required this.homeProvider,
  }) : super(key: key);

  final HomeProvider? homeProvider;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late AppStateManager appManager;

  onRetryClick() {
    widget.homeProvider!.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    appManager = Provider.of<AppStateManager>(context);
    Provider.of<AppStateManager>(context);
    if (widget.homeProvider!.isLoading) {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Expanded(
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 48.0,
                                      height: 48.0,
                                      color: Colors.white),
                                  const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0)),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            color: Colors.white),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0)),
                                        Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            color: Colors.white),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0)),
                                        Container(
                                            width: 40.0,
                                            height: 8.0,
                                            color: Colors.white)
                                      ]))
                                ])),
                        itemCount: 12)))
          ]));
    } else if (widget.homeProvider!.isError) {
      return NoitemScreen(
          title: t.oops, message: t.dataloaderror, onClick: onRetryClick);
    } else
      return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: DefaultTabController(
              length: 2, //
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        height: 60,
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 10),
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(
                                          InboxListScreenState.routeName),
                                  icon: Icon(Icons.notifications, size: 32)),
                              Text(
                                'HOME',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: appManager.preferredTheme == 1
                                        ? Colors.white
                                        : MyColors.primary),
                              ),
                              IconButton(
                                  padding:
                                      EdgeInsets.only(right: 15, bottom: 10),
                                  onPressed: () => Navigator.pushNamed(
                                      context, SearchScreen.routeName),
                                  icon: Icon(Icons.search, size: 32))
                            ])),
                    Container(
                        width: double.infinity,
                        height: 50,
                        child: TabBar(
                            indicator: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: appManager.preferredTheme == 1
                                            ? Colors.white
                                            : MyColors
                                                .primary, // Replace with the color you want for the selected tab's border
                                        width:
                                            2.0 // Replace with the width you want for the selected tab's border
                                        ))),
                            tabs: [
                              Tab(
                                  child: Text('SERMONS',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: appManager.preferredTheme == 1
                                              ? Colors.white
                                              : MyColors.primary))),
                              Tab(
                                  child: Text('LIVE',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: appManager.preferredTheme == 1
                                              ? Colors.white
                                              : MyColors.primary)))
                            ])),
                    Expanded(
                        child: TabBarView(children: [
                      // Content of Tab 1
                      SermonsWidget(homeProvider: widget.homeProvider),
                      // Content of Tab 2
                      LivestreamsPlayer(
                          liveStreams: widget.homeProvider!.data['livestream']
                              as LiveStreams?)
                    ])),
                    // Expanded(
                    //   child: HomePageBody(
                    //     homeProvider: homeProvider,
                    //     key: UniqueKey(),
                    //   ),
                    // ),
                    MiniPlayer()
                  ])));
  }
}
