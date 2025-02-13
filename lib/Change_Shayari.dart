import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/Welcome_Page.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'AllData.dart';
import 'Home_Page.dart';
import 'One_By_One_Shayari.dart';

class Change_Shayari extends StatefulWidget {
  int CategoryIndex;
  int ShayariIndex;
  Change_Shayari(this.ShayariIndex,this.CategoryIndex, {super.key});

  @override
  State<Change_Shayari> createState() => _Change_ShayariState();
}


double fontSize=30;
String fontFamily="";

class _Change_ShayariState extends State<Change_Shayari> {

  List SelectShayariList=[];
  bool ChangeColor=true;
  List<Color> selectColor=[];
  List<Color> SelectedColorList=[];
  List<String> ButtonNameEnglish=["Backgroud","Text Color","Share","Font","Emoji","Text Size"];
  List<String> ButtonNameHindi=["पृष्ठभूमि", "पाठ रंग", "साझा करें", "फ़ॉन्ट", "इमोजी", "पाठ आकार"];
  Color? bgColor;
  Color? textColor;
  late PageController pageController;
  late WidgetsToImageController imageController = WidgetsToImageController();
  Uint8List? bytes;
  var path;
  late int EmojiIndex;
  List EmojiList=AllData.emoji;
  late Directory directory;

  @override
  initState(){
    // TODO: implement initState
    super.initState();
    pageController=PageController(initialPage: widget.ShayariIndex);
    EmojiIndex=widget.ShayariIndex;
    // EmojiList.add("${translate?"Without Emoji":"बिना इमोजी"}");
  }

  @override
  Widget build(BuildContext context) {
    // if(EmojiList.contains("Without Emoji") || EmojiList.contains("बिना इमोजी")){
      EmojiList.remove("Without Emoji");
      EmojiList.remove("बिना इमोजी");
      EmojiList.add("${translate?"Without Emoji":"बिना इमोजी"}");
    // }
    String SelectShayari=AllData.CategoryListEnglish[widget.CategoryIndex].toString().replaceAll(" Shayari", "");
    SelectShayari=SelectShayari.replaceAll(" ", "_");
    SelectShayari=translate?SelectShayari+"ShayariAllListEnglish":SelectShayari+"ShayariAllListHindi";
    SelectShayariList=AllData.ShayariMapLikeList[SelectShayari]!;
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;
    if(ChangeColor){
      setColor();
    }
    storeData();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight*0.08,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 29, 61),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black)]
                ),
                child: Row(
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
              WidgetsToImage(
                controller: imageController,
                child: Container(
                    width: screenWidth-40,
                    height: screenHeight*0.60,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: (bgColor==null)?RadialGradient(colors: selectColor):null,
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black
                          )
                        ]
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        "${(EmojiIndex!=EmojiList.length)?EmojiList[EmojiIndex]:""} ${SelectShayariList.elementAt(widget.ShayariIndex)} ${(EmojiIndex!=EmojiList.length)?EmojiList[EmojiIndex]:""}",
                        style: TextStyle(
                            color: textColor==null?Color.fromARGB(255, 255, 255, 255):textColor,
                            // fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          fontFamily: fontFamily!=""?fontFamily:null
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ),
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 29, 61),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100)
                  ),
                  boxShadow: [BoxShadow(blurRadius: 20,color: Colors.black)]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 44, 49, 89),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: () {
                              setState(() {
                                ChangeColor=true;
                                bgColor=null;
                              });
                            }, icon: Icon(
                              CupertinoIcons.refresh_circled,
                              color: Colors.white,
                              size: 25,
                            )
                          ),
                            IconButton(onPressed: () {
                              setState(() {
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
                                            selectColor=SelectGradintColorList[index];
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
                              });
                            }, icon: Icon(Icons.open_with_sharp,color: Colors.white,size: 25,))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth-20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              //Backgroud
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    constraints: BoxConstraints(maxHeight: screenHeight/5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return GridView.builder(
                                        itemCount: AllData.bgColorNameList.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 8,
                                            mainAxisSpacing: 2,
                                            crossAxisSpacing: 2
                                        ), itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            bgColor=AllData.bgColorNameList[index];
                                            setState(() { });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                            color: AllData.bgColorNameList[index],
                                              borderRadius: BorderRadius.all(Radius.circular(3))
                                            ),
                                          ),
                                        );
                                      },);
                                    },);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: screenWidth*0.30,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 44, 49, 89),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Text(
                                    "${translate?ButtonNameEnglish.elementAt(0):ButtonNameHindi.elementAt(0)}",
                                    style: TextStyle(
                                      // fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255)
                                    ),
                                  )
                                ),
                              ),

                              //Text Color
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    constraints: BoxConstraints(maxHeight: screenHeight/6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return GridView.builder(
                                        itemCount: AllData.textColorNameList.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 8,
                                            mainAxisSpacing: 2,
                                            crossAxisSpacing: 2
                                        ), itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            textColor=AllData.textColorNameList[index];
                                            setState(() { });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: AllData.textColorNameList[index],
                                                borderRadius: BorderRadius.all(Radius.circular(3))
                                            ),
                                          ),
                                        );
                                      },);
                                    },);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: screenWidth*0.30,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 44, 49, 89),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                      "${translate?ButtonNameEnglish.elementAt(1):ButtonNameHindi.elementAt(1)}",
                                      style: TextStyle(
                                          // fontSize: 20,
                                          color: Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    )
                                ),
                              ),

                              //Share
                              InkWell(  
                                onTap: () async {
                                  bytes = await imageController.capture();
                                  final now=DateTime.now();
                                  path="${directory.path}/shayari_image${now.day}${now.month}${now.year}_${now.hour}${now.minute}${now.second}${now.millisecond}.png";

                                  final imageFile = File(path);
                                  await imageFile.writeAsBytes(bytes!);

                                  await Share.shareXFiles([XFile(path)]);

                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: screenWidth*0.30,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 44, 49, 89),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                      "${translate?ButtonNameEnglish.elementAt(2):ButtonNameHindi.elementAt(2)}",
                                      style: TextStyle(
                                          // fontSize: 20,
                                          color: Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    )
                                ),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Font
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Color.fromARGB(255, 24, 29, 61),
                                    shape: Border.fromBorderSide(BorderSide.none),
                                    constraints: BoxConstraints(maxHeight: 100),
                                    context: context,
                                    builder: (context) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 9,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            fontFamily="F$index";
                                            setState(() { });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(bottom: 25,top: 25,left: 10,right: 10),
                                            child: Text("${translate?"Shayari":"शायरी"}",style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(255, 24, 29, 61),
                                              fontFamily: "F$index"
                                            ),),
                                          ),
                                        );
                                    },);
                                  },);
                                },
                                child: Container(
                                    width: screenWidth*0.30,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 44, 49, 89),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                      "${translate?ButtonNameEnglish.elementAt(3):ButtonNameHindi.elementAt(3)}",
                                      style: TextStyle(
                                          // fontSize: 20,
                                          color: Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    )
                                ),
                              ),

                              // Emoji
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: Border.fromBorderSide(BorderSide.none),
                                    context: context,
                                    constraints: BoxConstraints(maxHeight: screenHeight/3),
                                    builder: (context) {
                                      return ListView.builder(
                                        itemCount: EmojiList.length,
                                        itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {

                                            if(EmojiList.length-1==index){
                                              EmojiIndex=EmojiList.length;
                                            }else{
                                              EmojiIndex=index;
                                            }
                                            setState(() { });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 24, 29, 61),
                                              border: Border(bottom: BorderSide(width: 3,color: Colors.white))
                                            ),
                                            child: Text(
                                              "${EmojiList[index]}",
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                        );
                                      },);
                                  },);
                                },
                                child: Container(
                                    width: screenWidth*0.30,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 10,bottom: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 44, 49, 89),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                      "${translate?ButtonNameEnglish.elementAt(4):ButtonNameHindi.elementAt(4)}",
                                      style: TextStyle(
                                          // fontSize: 20,
                                          color: Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    )
                                ),
                              ),

                              // Text Size
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: Border.fromBorderSide(BorderSide.none),
                                    constraints: BoxConstraints(maxHeight: screenHeight/10),
                                    backgroundColor: Color.fromARGB(255, 24, 29, 61),
                                    context: context,
                                    builder: (context) {
                                    return StatefulBuilder(builder: (context, setState1) {
                                      return Slider(
                                        min: 30,
                                        max: 70,
                                        value: fontSize,
                                        onChanged: (value) {
                                          fontSize=value;
                                          setState1(() { });
                                          setState(() { });
                                      },);
                                    },);
                                  },);
                                },
                                child: Container(
                                    width: screenWidth*0.30,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 10,bottom: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 44, 49, 89),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Text(
                                      "${translate?ButtonNameEnglish.elementAt(5):ButtonNameHindi.elementAt(5)}",
                                      style: TextStyle(
                                          // fontSize: 20,
                                          color: Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    )
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> storeData() async {
    path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    path="$path/shayari";
    directory=Directory(path);
    if(!await directory.exists()){
      directory.create();
    }
  }
  void setColor(){
    ChangeColor=false;
    selectColor.clear();
    selectColor=[
      for(int i=1;i<=Random().nextInt(15)+2;i++)
        (AllData.bgColorNameList[Random().nextInt(AllData.bgColorNameList.length)])
    ];
  }
}
