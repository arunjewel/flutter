import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'test.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyPage());
  }
}

class MyPage extends StatefulWidget {
  @override
  PageState createState() => PageState();
}

class PageState extends State<MyPage>  with SingleTickerProviderStateMixin {
  TabController controller;
  // final String title;

//  _MyPageState({Key key, this.title}) : super();

  Widget defaultBar(BuildContext context, Function changeAppBar) {
    return SliverAppBar(
      centerTitle: true,
      snap: true,
      floating: true,
      expandedHeight: 110.0,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            'https://www.itl.cat/pngfile/big/107-1070541_handsome-boys-fb-dps-zayn-malik-one-direction.jpg',
            height: 50.0,
            width: 50.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text('FLASHAT'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.lightGreenAccent[700],
      bottom: TabBar(
        tabs: [
          Tab(text: 'PERSONAL',),
          Tab(text: 'BUSINESS',),
          Tab(text: 'HUDDLES',),
          Tab(text: 'CALLS',),
        ],
        controller: controller,
      ),
    );

  }


  Widget onclickBar(BuildContext context, Function changeAppBar) {
    return SliverAppBar(
      title: const Text('Books'),
      floating: true,
      pinned: true,
      snap: false,
      primary: true,
      //forceElevated: innerBoxIsScrolled,
      // bottom: TabBar(
      //   // These are the widgets to put in each tab in the tab bar.
      //  // tabs: _tabs.map((String name) => Tab(text: name)).toList(),
      // ),
    );

  }

  bool Selected = true;

  //AppBar _appBar = defaultBar;
  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 4,
      vsync: this,
    );
  }



  @override
  void appBarChange() {

      print('changed');
      Selected = !Selected;
      print(Selected);
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[

          Selected
              ? defaultBar(context, appBarChange) : onclickBar(context, appBarChange),

      //   SliverAppBar(
      //   centerTitle: true,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(25.0),
      //       child: Image.network(
      //         'https://www.itl.cat/pngfile/big/107-1070541_handsome-boys-fb-dps-zayn-malik-one-direction.jpg',
      //         height: 50.0,
      //         width: 50.0,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      //   title: Text('FLASHAT'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.more_vert),
      //       onPressed: () {},
      //     ),
      //   ],
      //   backgroundColor: Colors.lightGreen,
      //   bottom: TabBar(
      //     tabs: [
      //       Tab(text: 'PERSONAL',),
      //       Tab(text: 'BUSINESS',),
      //       Tab(text: 'HUDDLES',),
      //       Tab(text: 'CALLS',),
      //     ],
      //     controller: controller,
      //   ),
      // ),







      SliverFillRemaining(
          child: TabBarView(
            controller: controller,
              children: <Widget>[
                Center(child: JobsListView(),),

                Center(child: JobsListView(),),

                Center(child: JobsListView(),),
                Center(key: ValueKey('4'), child: Text("Calls")),

              ],
            ),)
         ], ),
        );
  }
  void reload() {
    print('reload set');
    if(this.mounted) {

      setState(() {
//         _appBar = _appBar == defaultBar
//             ? onclickBar
//             : defaultBar;
//
// return PageState();
      });
    }
    // setState(() {
    //    _appBar =onclickBar;
    //   _appBar = _appBar == _defaultBar
    //       ? onclickBar
    //       : _defaultBar;
    // });
  }
}
