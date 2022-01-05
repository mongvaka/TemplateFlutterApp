import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_list_page.dart';

import 'Shared/Widget/appbar_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexPage = 0;
  List<Widget> widgetList = [
    Text('HOME'),
    BankListPage(),
    Text('CRUD2'),
    Text('DEMO'),
    Text('OPTION')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetList.elementAt(indexPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        selectedItemColor: Colors.blue,
        currentIndex: indexPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'CRUD'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dock), label: 'CRUD2', tooltip: 'ffff'),
          BottomNavigationBarItem(icon: Icon(Icons.watch), label: 'DEMO'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'OPTION')
        ],
        onTap: (index) {
          setState(() {
            print(index);
            indexPage = index;
          });
        },
      ),
    );
  }
}

// class Homepage extends StatelessWidget {
//   const Homepage({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text('thisHompage'),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: 'lb1'),
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: 'lb1')
//         ],
//       ),
//     );
//   }
// }
