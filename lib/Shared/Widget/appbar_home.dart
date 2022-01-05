import 'package:flutter/material.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Appbar'),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.notifications_none), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
            // backgroundColor: Colors.orange,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.red],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft)),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.face),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Home',
                )
              ],
            ),
            elevation: 20,
            titleSpacing: 0,
          ),
          body: TabBarView(
            children: [
              buildPage('Home page'),
              buildPage('Feed page'),
              buildPage('Profile page'),
              buildPage('Setting page')
            ],
          ),
        ),
        // body: Container(),
      );

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 28),
        ),
      );
}
