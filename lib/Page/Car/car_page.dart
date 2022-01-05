import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ice_fac_mobile/Page/Car/car_service.dart';
import 'package:ice_fac_mobile/Page/Login/login_page.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/ViewModel/car_list_view.dart';
import 'package:ice_fac_mobile/constants.dart';

class CarListPage extends StatelessWidget {
  const CarListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CarServeice carService = new CarServeice();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CarDropdownPage(),
    );
  }
}

class CarDropdownPage extends StatefulWidget {
  CarDropdownPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CarDropdownPageState createState() => _CarDropdownPageState();
}

class _CarDropdownPageState extends State<CarDropdownPage> {
  String _Selected;
  CarServeice carServeice = new CarServeice();
  // Future getDropDownCar() async {
  //   var car = await carServeice.getCarList();
  //   print('$car');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: formAppBar(context),
      body: FutureBuilder(
        future: carServeice.getCarList(new SearchParameterModel()),
        builder:
            (BuildContext context, AsyncSnapshot<List<CarListView>> snapshot) {
          if (snapshot.hasData) {
            List<CarListView> carList = snapshot.data;
            return ListView(
              children: carList
                  .map((CarListView car) => ListTile(
                        title: Text(car.car_name),
                      ))
                  .toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Align formDorpDown() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: kLabelColor),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Text('Select Car'),
                      value: _Selected,
                      onChanged: (newValue) {
                        setState(() {
                          _Selected = newValue;
                        });
                      },
                      // items: myJson.map((carItem) {
                      //   return DropdownMenuItem(
                      //       child: Center(
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           child: Text(carItem['car_code']),
                      //         ),
                      //         Container(
                      //           margin: EdgeInsets.only(left: 10),
                      //           child: Text(carItem['car_name']),
                      //         )
                      //       ],
                      //     ),
                      //   ));
                      // }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar formAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("Car list"),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/Log out.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );
  }
}
