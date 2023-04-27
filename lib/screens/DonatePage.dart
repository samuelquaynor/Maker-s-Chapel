import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/ApiUrl.dart';
import '../utils/my_colors.dart';
import 'BibleScreen.dart';
import 'SearchScreen.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  bool isLoading = true;
  late WebViewController controllerGlobal;

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      await controllerGlobal.goBack();
      return Future.value(false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No back history item')));
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Column(
        children: [
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
                      'DONATE',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        padding: EdgeInsets.only(right: 15, bottom: 10),
                        onPressed: () => Navigator.pushNamed(
                            context, SearchScreen.routeName),
                        icon: Icon(Icons.search, size: 32))
                  ])),
          Expanded(
            child: Stack(children: [
              WebView(
                  initialUrl: ApiUrl.DONATE,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  }),
              if (isLoading)
                Container(
                  color: Colors.white,
                  child: const SizedBox.expand(
                      child: Center(child: CircularProgressIndicator())),
                )
              else
                Stack()
            ]),
          ),
        ],
      ),
    ));
  }
}
