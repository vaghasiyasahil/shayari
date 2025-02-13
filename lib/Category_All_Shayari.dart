import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shayari/AllData.dart';
import 'package:shayari/Home_Page.dart';
import 'package:shayari/One_By_One_Shayari.dart';
import 'package:shayari/Welcome_Page.dart';

class Category_All_Shayari extends StatefulWidget {
  int CategoryIndex;
  Category_All_Shayari(this.CategoryIndex, {super.key});

  @override
  State<Category_All_Shayari> createState() => _Category_All_ShayariState();
}
class _Category_All_ShayariState extends State<Category_All_Shayari> {
  List<bool> MainCategoryColorTemp=[];
  List CategoryAllShayariPageImage=[];
  bool CategoryAllShayariHindi=true;

  @override
  void initState() {
    super.initState();
    MainCategoryColorTemp = List.filled(AllData.CategoryListEnglish.length, true);
  }

  @override
  Widget build(BuildContext context) {
    String CategoryName=AllData.CategoryListEnglish.elementAt(widget.CategoryIndex).toString().replaceAll(" Shayari", "");
    CategoryName=CategoryName.replaceAll(" ","_");
    String ListName=CategoryName+"ShayariAllList"+(translate?"English":"Hindi");
    List SelectShayari=AllData.ShayariMapLikeList[ListName]!;
    if(CategoryAllShayariHindi){
      CategoryAllShayariHindi=false;
      for(int i=0;i<SelectShayari.length;i++){
        CategoryAllShayariPageImage.add(AllData.CategoryImageList.elementAt(widget.CategoryIndex).elementAt(Random().nextInt(AllData.CategoryImageList.elementAt(i).length)));
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
        body: ListView.builder(
          itemCount: SelectShayari.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => One_BY_One_Shayari(SelectShayari.length,widget.CategoryIndex,index),));
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
                  height: 60,
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
                            // "assets/Category/${AllData.CategoryImageList.elementAt(widget.CategoryIndex).elementAt(Random().nextInt(AllData.CategoryImageList.elementAt(index).length))}",
                            "assets/Category/${CategoryAllShayariPageImage.elementAt(index)}",
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image);
                            },
                          ),
                        )
                    ),

                    //Main Title Code
                    title: Text(
                      "${AllData.emoji[index]} ${SelectShayari.elementAt(index)} ${AllData.emoji[index]}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 24, 29, 61),
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
      );
    }
  }