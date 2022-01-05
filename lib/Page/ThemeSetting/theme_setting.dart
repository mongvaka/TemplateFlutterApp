import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Navigator/navigator.dart';
import 'package:ice_fac_mobile/Shared/Widget/appbar_item_widget.dart';
import 'package:ice_fac_mobile/Shared/Widget/color_cell.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:ice_fac_mobile/Utils/constants.dart';
import 'package:provider/src/provider.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({Key key}) : super(key: key);

  @override
  _ThemeSettingState createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  final List<String> items = Constans.languages;
  final List<double> fontSizes = Constans.fontSizes;
  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
    return Scaffold(
      appBar: AppbarItem(
        actions: null,
        title: 'FIRST_TEXT'.tr(),
      ).build(context),
      body: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        color: Colors.white,
        home: Column(
          children: [
            Text(
              'FIRST_TEXT'.tr(),
              style: TextStyle(fontSize: context.watch<Appsetting>().fontSize),
            ),
            Wrap(
              children: List<Widget>.generate(Constans.colors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    context.read<Appsetting>().updateColor(index);
                  },
                  child: ColorCell(
                    color: Constans.colors[index],
                  ),
                );
              }),
            ),
            DropdownButton(
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) {
                NavigationService.navigatorKey.currentContext
                    .setLocale(Locale(value));
                // _context.locals =
                // print(value);
              },
            ),
            DropdownButton(
              items: fontSizes.map(buildMenuFontSizeItem).toList(),
              onChanged: (value) {
                context.read<Appsetting>().updateFontSize(value);

                // NavigationService.navigatorKey.currentContext
                //     .setLocale(Locale(value));
                // _context.locals =
                // print(value);
              },
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );
  DropdownMenuItem<double> buildMenuFontSizeItem(double item) =>
      DropdownMenuItem(
        child: Text(item.toString()),
        value: item,
      );
}
