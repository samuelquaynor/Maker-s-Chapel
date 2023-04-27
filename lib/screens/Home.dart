import 'package:churchapp_flutter/screens/DonatePage.dart';
import 'package:churchapp_flutter/screens/Downloader.dart';

import '../models/Userdata.dart';
import 'package:provider/provider.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter/material.dart';
import '../providers/HomeProvider.dart';
import 'BibleScreen.dart';
import 'DrawerScreen.dart';
import 'HomeWidget.dart';
import 'LibraryPage.dart';

enum HomeIndex { CATEGORIES, VIDEOS, AUDIOS, BIBLEBOOKS, LIVESTREAMS, RADIO }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.userdata}) : super(key: key);
  final Userdata? userdata;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeProvider? homeProvider;

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).loadItems();
    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);

    List pages = [
      HomeWidget(
        homeProvider: homeProvider,
      ),
      LibraryPage(),
      DonatePage(),
      Downloader(),
      DrawerScreen()
    ];

    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
                color: MyColors.primary,
                onPressed: () =>
                    Navigator.of(context).pushNamed(BibleScreen.routeName),
                icon: Icon(Icons.book, size: 32)),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColors.primary,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: MyColors.primary,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books,
                  color: MyColors.primary,
                ),
                label: 'Library'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.monetization_on_outlined,
                  color: MyColors.primary,
                ),
                label: 'Donate'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.download,
                  color: MyColors.primary,
                ),
                label: 'Downloads'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: MyColors.primary,
                ),
                label: 'Profile')
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped),
      body: pages.elementAt(_selectedIndex),
    );
  }
}
