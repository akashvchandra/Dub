import 'dart:async';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './texttospeech.dart';
import './translate.dart';
import './predefinedwords.dart';
import './drawerpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentindex = 0;

  final List<Widget> _childern = [TextToSpeech(), Translate(), EmotePage1()];

  void ontappedbar(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the app!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue, // navigation bar color,
        statusBarColor: HexColor("#231f20"), // status bar color,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      darkTheme: ThemeData.dark(),
      home: WillPopScope(
          onWillPop: () async {
            if (_currentindex == 0) {
              return _onBackPressed();
            }
            setState(() {
              _currentindex = 0;
            });
            return false;
          },
          child: Scaffold(
            appBar: _appbar,
            drawer: Pageofdrawer(),
            body: _childern[_currentindex],
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.blue,
              ),
              child: bottomNavigationBar,
            ),
          )),
    );
  }

  Widget get _appbar {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/Logo strip top gap.png",
                    ),
                    fit: BoxFit.fill)),
          ),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        )),
      ),
    );
  }

  Widget get bottomNavigationBar {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[500],
      showUnselectedLabels: true,
      elevation: 10,
      onTap: ontappedbar,
      currentIndex: _currentindex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker),
          title: Text('Speech'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.translate), title: Text('Translate')),
        BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions), title: Text('Emote')),
      ],
    );
  }
}
