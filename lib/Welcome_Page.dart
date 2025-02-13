import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari/Home_Page.dart';

import 'AllData.dart';

class Welcome_Page extends StatefulWidget {
  const Welcome_Page({super.key});

  @override
  State<Welcome_Page> createState() => _Welcome_PageState();
}
double screenWidth=0;
double screenHeight=0;
class _Welcome_PageState extends State<Welcome_Page> {
  var status;

  @override
  initState(){
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  bool color=true;
  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 29, 61),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 15,top: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
                  ),
                  child: Image.asset(
                    "assets/welcome_img.png",
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 24, 29, 61),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${AllData.WelcomeTitle}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 230, 234, 243)
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${AllData.WelcomeTitleBio}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page(),));
                        },
                        onTapDown: (details) {
                          setState(() {
                            color=false;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            color=true;
                          });
                        },
                        onHorizontalDragCancel: () {
                          setState(() {
                            color=true;
                          });
                        },
                        onVerticalDragCancel: () {
                          setState(() {
                            color=true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: color?Color.fromARGB(255, 245, 83, 96):Color.fromARGB(125, 76, 76, 100),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(
                            "${AllData.WelcomeButton}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 230, 234, 243),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> getPermission() async {
    status = await Permission.storage.status;
    // if(status.isDenied){
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.storage,
      ].request();
    // }
  }
}
