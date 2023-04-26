import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../i18n/strings.g.dart';
import '../providers/AppStateManager.dart';
import '../screens/HomePage.dart';
import '../utils/my_colors.dart';
import '../utils/TextStyles.dart';
import '../models/Onboarder.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = "/onboarding";
  OnboardingPage();

  @override
  OnboarderPageState createState() => new OnboarderPageState();
}

class OnboarderPageState extends State<OnboardingPage> {
  List<Onboarder> onboarderItem = Onboarder.getOnboardingItems([
    "Welcome to tmh, this is home.",
    "Be Closer to God",
    "The place where God dwells",
    "Join our family"
  ], [
    "Welcome to the Maker's House Chapel International, a place of a caring and gracious spirit ― a spirit directly attributable to Christ’s presence in the church’s life and people. We minister to all backgrounds, including families and students.",
    "At TMH, you can spread the love to everyone, reach lost & broken people and meet them right where they are. Our church is a place where people share love and care for one another.",
    "The vision of discovery is to be a church of grace-filled people, so that the Gospel is transferred from generation to generation.",
    "Become a part of the TMH and experience how the word of God changes lives. Feel free to join our church and the community of TMH that will help you on your way to discovering the power of Jesus Christ."
  ], onboarderUrls: [
    'assets/images/onboardone.jpg',
    'assets/images/onboardtwo.jpg',
    'assets/images/onboardthree.jpg',
    'assets/images/obboardfinal.jpg',
  ]);
  PageController pageController = PageController(
    initialPage: 0,
  );
  int page = 0;
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(color: Colors.grey[100])),
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: onPageViewChange,
            controller: pageController,
            children: buildPageViewItem(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: buildDots(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text(isLast ? t.done : t.next,
                    style: TextStyles.subhead(context).copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  if (isLast) {
                    Provider.of<AppStateManager>(context, listen: false)
                        .setUserSeenOnboardingPage(true);
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                    return;
                  }
                  pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.close, color: MyColors.grey_40),
                onPressed: () {
                  Provider.of<AppStateManager>(context, listen: false)
                      .setUserSeenOnboardingPage(true);
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    isLast = _page == onboarderItem.length - 1;
    setState(() {});
  }

  List<Widget> buildPageViewItem() {
    List<Widget> widgets = [];
    for (Onboarder onboarder in onboarderItem) {
      Widget wg = Container(
        padding: EdgeInsets.all(35),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(onboarder.url ?? ""), fit: BoxFit.cover)),
        child: Container(
          color: Color.fromARGB(73, 0, 0, 0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Wrap(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(onboarder.title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyles.medium(context).copyWith(
                                color: MyColors.white,
                                fontFamily: "serif",
                                fontWeight: FontWeight.bold,
                                fontSize: 23)),
                        Container(
                          width: 120,
                          height: 2,
                          color: MyColors.primary,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: Text(onboarder.hint,
                              textAlign: TextAlign.center,
                              style: TextStyles.subhead(context)
                                  .copyWith(color: MyColors.white)),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
      widgets.add(wg);
    }
    return widgets;
  }

  Widget buildDots(BuildContext context) {
    Widget widget;

    List<Widget> dots = [];
    for (int i = 0; i < onboarderItem.length; i++) {
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 8,
        width: 8,
        child: CircleAvatar(
          backgroundColor: page == i ? MyColors.primary : MyColors.grey_20,
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}
