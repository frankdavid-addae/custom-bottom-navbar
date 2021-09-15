// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CustomNavBarApp());
}

class CustomNavBarApp extends StatelessWidget {
  const CustomNavBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Nav Bar',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = Get.height;
    debugPrint(mediaQueryHeight.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Nav Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Nav Item: $_selectedItem',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: Platform.isIOS
            ? mediaQueryHeight < 900
                ? 55
                : 70.0
            : 45.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        child: CustomBottomNavigationBar(
          onChange: (value) {
            setState(() {
              _selectedItem = value;
            });
          },
          iconList: [
            Icons.home,
            Icons.qr_code_scanner_outlined,
            Icons.keyboard,
            Icons.message_rounded
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  const CustomBottomNavigationBar({
    Key? key,
    this.defaultSelectedIndex = 0,
    required this.onChange,
    required this.iconList,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) => Column(
        mainAxisAlignment: Platform.isIOS && Get.height > 900
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              widget.onChange(index);
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Platform.isIOS
                ? SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: Icon(
                      icon,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  )
                : SizedBox(
                    height: 40.0,
                    width: 50.0,
                    child: Icon(
                      icon,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
          ),
          index == _selectedIndex
              ? Container(
                  height: 4.0,
                  width: 50.0,
                  color: Colors.black,
                )
              : Container(),
        ],
      );
}
