import 'package:churchapp_flutter/screens/HymnsListScreen.dart';
import 'package:flutter/material.dart';

import '../notes/NotesListScreen.dart';
import '../utils/my_colors.dart';
import 'BibleScreen.dart';
import 'DevotionalScreen.dart';
import 'EventsListScreen.dart';
import 'SearchScreen.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 4, //
            child: Column(children: [
              Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(BibleScreen.routeName),
                            icon: Icon(Icons.book, size: 32)),
                        Text(
                          'LIBRARY',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                            padding: EdgeInsets.only(right: 15, bottom: 10),
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
                                  color: MyColors
                                      .primary, // Replace with the color you want for the selected tab's border
                                  width:
                                      2.0 // Replace with the width you want for the selected tab's border
                                  ))),
                      tabs: [
                        Tab(
                            child: Text('DEVOTION',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))),
                        Tab(
                            child: Text('HYMNS',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))),
                        Tab(
                            child: Text('NOTES',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))),
                        Tab(
                            child: Text('EVENTS',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ))),
                      ])),
              Expanded(
                  child: TabBarView(children: [
                DevotionalScreen(),
                HymnsListScreen(),
                NotesListScreen(),
                EventsListScreen()
              ])),
            ])));
  }
}
