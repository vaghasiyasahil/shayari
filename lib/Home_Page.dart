import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shayari/AllData.dart';
import 'package:shayari/Category_All_Shayari.dart';
import 'package:shayari/Welcome_Page.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}
bool translate=true;
class _Home_PageState extends State<Home_Page> {
  List<bool> SubCategoryColorTemp=[];
  List<bool> MainCategoryColorTemp=[];
  List HomePageImage=[];
  bool HomePageImageTemp=true;

  @override
  void initState() {
    super.initState();
    SubCategoryColorTemp = List.filled(AllData.CategoryListEnglish.length, true);
    MainCategoryColorTemp = List.filled(AllData.CategoryListEnglish.length, true);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;
    if(HomePageImageTemp) {
      HomePageImageTemp=false;
      for(int i=0;i<AllData.CategoryListEnglish.length;i++){
        HomePageImage.add(AllData.CategoryImageList.elementAt(i).elementAt(Random().nextInt(AllData.CategoryImageList.elementAt(i).length)));
      }
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 24, 29, 61),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_double_arrow_left, color: Colors.blueGrey,size: 30,)
            ),
            Text(
              "${translate?AllData.AppbarEnglish:AllData.AppbarHindi}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            IconButton(
                onPressed: (){
                  translate=translate?false:true;
                  setState(() { });
                },
                icon: Icon(Icons.g_translate, color: Colors.blueGrey,size: 20,)
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 130,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 29, 61),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      alignment: Alignment.center,
                      width: screenWidth-70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 44, 49, 89),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AllData.CategoryListHindi.length,
                        itemBuilder: (context, index) {
                          String Category=translate?AllData.CategoryListEnglish.elementAt(index):AllData.CategoryListHindi.elementAt(index);
                          String SubCategory=translate?Category.replaceAll(" Shayari", ""):Category.replaceAll(" शायरी", "");
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Category_All_Shayari(index),));
                            },
                            onTapDown: (details) {
                              setState(() {
                                SubCategoryColorTemp[index] = false;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                SubCategoryColorTemp[index] = true;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                SubCategoryColorTemp[index] = true;
                              });
                            },
                            child: Container(
                              // width: 100,
                              height: 50,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: SubCategoryColorTemp[index]?Color.fromARGB(255, 24, 29, 61):Color.fromARGB(255, 245, 83, 96),
                                  borderRadius: BorderRadius.all(Radius.circular(10)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                    blurRadius: 1
                                  )
                                ]
                              ),
                              child: Text(
                                "$SubCategory",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 230, 234, 243),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 24, 29, 61),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(60))
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: screenWidth,
                        child: Text(
                          "${translate?AllData.CategoryTitleEnglish:AllData.CategoryTitleHindi}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 29, 61),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: AllData.CategoryListEnglish.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Category_All_Shayari(index),));
                              },
                              onTapDown: (details) {
                                setState(() {
                                  MainCategoryColorTemp[index]=false;
                                });
                              },
                              onTapUp: (details) {
                                setState(() {
                                  MainCategoryColorTemp[index]=true;
                                });
                              },
                              onTapCancel: () {
                                setState(() {
                                  MainCategoryColorTemp[index]=true;
                                });
                              },
                              child: Card(
                                color: Color.fromARGB(255, 44, 49, 89),
                                margin: EdgeInsets.all(5),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  width: screenWidth-40,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: MainCategoryColorTemp[index]?Color.fromARGB(255, 255, 255, 255):Color.fromARGB(255, 245, 83, 96),
                                      borderRadius: BorderRadius.all(Radius.circular(10)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      )
                                    ]
                                  ),
                                  child: ListTile(

                                    // Image Code
                                    leading: Container(
                                      width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            // "assets/Category/${AllData.CategoryImageList.elementAt(index)}",
                                            // "assets/Category/${AllData.CategoryImageList.elementAt(index).elementAt(Random().nextInt(AllData.CategoryImageList.elementAt(index).length))}",
                                            "assets/Category/${HomePageImage.elementAt(index)}",
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.broken_image);
                                            },
                                          ),
                                        )
                                    ),

                                    //Main Title Code
                                    title: Text(
                                      "${translate?AllData.CategoryListEnglish.elementAt(index):AllData.CategoryListHindi.elementAt(index)}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    titleTextStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 24, 29, 61),
                                    ),

                                    //Sub Title Code
                                    subtitle: Text(
                                        "${translate?AllData.CategoryShortBioListEnglish.elementAt(index):AllData.CategoryShortBioListHindi.elementAt(index)}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitleTextStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blueGrey,
                                    ),

                                    //Icon Code
                                    trailing: Container(
                                      width: 20,
                                      child: Icon(CupertinoIcons.right_chevron),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}