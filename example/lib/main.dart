import 'package:flutter/material.dart';
import 'dart:async';
import 'package:material_load_scrollview/material_load_scrollview.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<MaterialLoadScrollViewState> _key =
      new GlobalKey(); //necessary for resetLoadStatus
  int _page = 1;
  final _itemCount = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MaterialLoadScrollView example'),
        ),
        body: MaterialLoadScrollView(
          key: _key,
          onRefresh: () {
            Future.delayed(Duration(seconds: 3)).then((_) {
              setState(() {
                _page = 1;
                _resetLoadStatus();
              });
            });
          },
          onLoadMore: () {
            Future.delayed(Duration(seconds: 3)).then((_) {
              setState(() {
                _page++;
                _resetLoadStatus();
              });
            });
          },
          child: ListView.builder(
            controller: ScrollController(),
            //necessary for scroll to top when onRefresh
            itemCount: _page * _itemCount,
            itemBuilder: (_, _i) => Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Text("$_i"),
                ),
          ),
        ),
      ),
    );
  }

  _resetLoadStatus() {
    _key.currentState.reset();
  }
}
