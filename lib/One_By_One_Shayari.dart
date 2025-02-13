import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/Change_Shayari.dart';
import 'package:shayari/Welcome_Page.dart';

import 'AllData.dart';
import 'Home_Page.dart';

class One_BY_One_Shayari extends StatefulWidget {
  int ShayatiIndex;
  int CategoryIndex;
  int TotalShayari;
  List<Color>? selectedColorList;
  One_BY_One_Shayari(this.TotalShayari,this.CategoryIndex,this.ShayatiIndex, {this.selectedColorList,super.key});

  @override
  State<One_BY_One_Shayari> createState() => _One_BY_One_ShayariState();
}

List<List<Color>> SelectGradintColorList=[
  for(int i=0;i<12;i++)
    [
      for(int j = 0; j < Random().nextInt(5) + 3; j++)
        AllData.bgColorNameList.elementAt(
            Random().nextInt(AllData.bgColorNameList.length))
    ]
];

class _One_BY_One_ShayariState extends State<One_BY_One_Shayari> {

  List<bool> BottomMenu=List.filled(5, true);
  List BottomMenuIconList=[
    Icons.copy_all_sharp,
    CupertinoIcons.left_chevron,
    Icons.edit_off_outlined,
    CupertinoIcons.right_chevron,
    Icons.share_sharp
  ];
  List<bool> TopMenu=List.filled(3, true);
  String SelectCategory="";
  List bgColor=[];
  bool colorTemp=true;
  PageController pageController=PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController(initialPage: widget.ShayatiIndex);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;
    ColorChange();
    SelectCategory=AllData.CategoryListEnglish[widget.CategoryIndex];
    SelectCategory=SelectCategory.replaceAll(" Shayari", "");
    SelectCategory=translate?SelectCategory+"ShayariAllListEnglish":SelectCategory+"ShayariAllListHindi";
    SelectCategory=SelectCategory.replaceAll(" ", "_");
    List SelectShayariList=AllData.ShayariMapLikeList[SelectCategory]!;
    List<Color> SelectedColorList=[];
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
                "${translate?AllData.CategoryListEnglish.elementAt(widget.CategoryIndex):AllData.CategoryListHindi.elementAt(widget.CategoryIndex)}",
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
      body: Container(
        color: Color.fromARGB(255, 44, 49, 89),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // color: Color.fromARGB(255, 24, 29, 61),
                      // width: screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return GridView.builder(
                                    itemCount: 12,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5
                                    ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        widget.selectedColorList=SelectGradintColorList[index];
                                        setState(() { });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                            gradient: RadialGradient(
                                                colors: SelectGradintColorList[index]
                                            )
                                        ),
                                      ),
                                    );
                                  },);
                                },);
                            },
                            onTapDown: (details) {
                              setState(() {
                                TopMenu[0]=false;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                TopMenu[0]=true;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                TopMenu[0]=true;
                              });
                            },
                            child: Container(
                              width: screenWidth/3,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: TopMenu[0]?Color.fromARGB(255, 24, 29, 61):Color.fromARGB(255, 44, 49, 89),
                                  borderRadius: BorderRadius.only(
                                  )
                              ),
                              child: Icon(
                                Icons.open_with_sharp,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: screenWidth/3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 24, 29, 61),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(TopMenu[0]?0:10),
                                bottomRight: Radius.circular(TopMenu[2]?0:10)
                              )
                            ),
                            child: Text(
                              "${translate?widget.ShayatiIndex+1:AllData.numberInHindi.elementAt(widget.ShayatiIndex)}/${translate?widget.TotalShayari:AllData.numberInHindi.elementAt(widget.TotalShayari-1)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.selectedColorList=null;
                                colorTemp=true;
                              });
                            },
                            onTapDown: (details) {
                              setState(() {
                                TopMenu[2]=false;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                TopMenu[2]=true;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                TopMenu[2]=true;
                              });
                            },
                            child: Container(
                              width: screenWidth/3,
                              height: 70,
                              color: TopMenu[2]?Color.fromARGB(255, 24, 29, 61):Color.fromARGB(255, 44, 49, 89),
                              child: Icon(
                                Icons.refresh_outlined,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.TotalShayari,
                  controller: pageController,
                  onPageChanged: (value) {
                    widget.ShayatiIndex=value;
                    setState(() { });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      height: screenHeight*0.50,
                      width: screenWidth-20,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: AllData.bgColorNameList.elementAt(Random().nextInt(AllData.bgColorNameList.length)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          gradient: RadialGradient(
                            colors: widget.selectedColorList==null
                                ? [
                              for(int i=0;i<bgColor.length;i++)
                                bgColor.elementAt(i)
                            ]
                                : widget.selectedColorList!,
                          ),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          "${AllData.emoji[widget.ShayatiIndex]} ${SelectShayariList[widget.ShayatiIndex]} ${AllData.emoji[widget.ShayatiIndex]}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              // fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: screenWidth,
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BottomMenu.length,
                        itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            colorTemp=false;
                            if(index==0){
                              String CopyStr="${AllData.emoji[widget.ShayatiIndex]} ${SelectShayariList[widget.ShayatiIndex]} ${AllData.emoji[widget.ShayatiIndex]}";
                              FlutterClipboard.copy(CopyStr).then((value) {
                                Fluttertoast.showToast(
                                    msg: "Copy Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Color.fromARGB(255, 24, 29, 61),
                                    textColor: Colors.white,
                                    fontSize: 25.0
                                );
                              });
                            }else if(index==1){
                              if(widget.ShayatiIndex>0){
                                widget.ShayatiIndex--;
                                pageController.jumpToPage(widget.ShayatiIndex);
                              }
                            }else if(index==2){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Change_Shayari(widget.ShayatiIndex,widget.CategoryIndex);
                              },));
                            }else if(index==3){
                              if(widget.ShayatiIndex!=widget.TotalShayari-1){
                                widget.ShayatiIndex++;
                                pageController.jumpToPage(widget.ShayatiIndex);
                              }
                            }else if(index==4){
                              Share.share(
                                  "${AllData.emoji[widget.ShayatiIndex]} ${SelectShayariList[widget.ShayatiIndex]} ${AllData.emoji[widget.ShayatiIndex]}",
                                  subject: '${translate?AllData.CategoryListEnglish.elementAt(widget.CategoryIndex):AllData.CategoryListHindi.elementAt(widget.CategoryIndex)}'
                              );
                            }
                            for(int i=0;i<BottomMenu.length;i++){
                              BottomMenu[i]=true;
                            }
                            // BottomMenu[index]=false;
                          },
                          onTapDown: (details) {
                            setState(() {
                              for(int i=0;i<BottomMenu.length;i++){
                                BottomMenu[i]=true;
                              }
                              BottomMenu[index]=false;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              for(int i=0;i<BottomMenu.length;i++){
                                BottomMenu[i]=true;
                              }
                              // BottomMenu[index]=false;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              for(int i=0;i<BottomMenu.length;i++){
                                BottomMenu[i]=true;
                              }
                              // BottomMenu[index]=false;
                            });
                          },
                          child: Container(
                            width: screenWidth/5,
                            decoration: BoxDecoration(
                                color: BottomMenu[index]?Color.fromARGB(255, 24, 29, 61):Color.fromARGB(255, 44, 49, 89),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(index == 0 || BottomMenu[index - 1] ? 0 : 10),
                                  topRight: Radius.circular(index == BottomMenu.length - 1 || BottomMenu[index + 1] ? 0 : 10),
                                  bottomLeft: Radius.circular(!BottomMenu[index]?10:0),
                                  bottomRight: Radius.circular(!BottomMenu[index]?10:0),
                                )
                            ),
                            child: Icon(
                              BottomMenuIconList.elementAt(index),
                              color: Color.fromARGB(255, 255, 255, 255),
                            )
                          ),
                        );
                      },),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
  void ColorChange()
  {
    if(colorTemp){
      colorTemp=false;
      bgColor.clear();
      for(int i=0;i<Random().nextInt(3)+2;i++) {
        bgColor.add(AllData.bgColorNameList.elementAt(Random().nextInt(AllData.bgColorNameList.length)));
      }
    }
  }
}