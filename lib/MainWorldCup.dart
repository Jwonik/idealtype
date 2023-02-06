import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:idealtype/landing_page.dart';
import 'package:idealtype/question_page.dart';
import 'package:idealtype/ranking.dart';
import 'package:idealtype/vo/commentVO.dart';
import 'package:idealtype/winner.dart';
import 'WorldCupItem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'landing_page.dart';

/*
실행하기전 pubspec.yaml에 아래 넣어줘야함
dependencies:
  build_runner: ^2.0.4
  json_annotation: ^4.0.1
  json_serializable: ^4.1.3
*/

final worldCupItem = {
  "list": [
    {"image": "images/귀여운동물/강아지.jpg", "name": "귀여운동물"},
    {"image": "images/면요리/냉면.jpg", "name": "면요리"},
    {"image": "images/무인도도구/곰인형.jpg", "name": "무인도도구"},
    {"image": "images/곤충/개미.jpg", "name": "곤충"},
    {"image": "images/과일/감.jpg", "name": "과일"},
    {"image": "images/휴양지/호주.jpg", "name": "휴양지"}
  ]
};

WorldCupList? worldCupList;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title : '이상형 월드컵',
        initialRoute: '/',
        routes: {
          '/':(context)=>WorldCupHome(),
          '/ranking':(context)=>Ranking(),
          // '/question':(context)=>QuestionPage(),
          '/landing':(context)=>LandingPage(),
          '/winner':(context)=>Winner()
        }
    );

  }
}


class WorldCupHome extends StatelessWidget {
  const WorldCupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    worldCupList = WorldCupList.fromJson(worldCupItem);
    return Scaffold(
      appBar: AppBar(
        title: const Text("골라보조"),
        centerTitle: true,
      ),
      body:
      GridView.count(
        physics: const ScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 45,
        children: List.generate(6, (index) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Image.asset(worldCupList!.list!.elementAt(index).image!,),
                ),
                Padding(padding: const EdgeInsets.only(top: 5),
                  child:
                  Text(
                    worldCupList!.list!.elementAt(index).name! + ' 월드컵',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 3, left: 16),
                  child:Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/landing' ,
                              arguments:  worldCupList!.list!.elementAt(index).name!);
                        },
                        child: const Text('시작하기'),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon:const Icon(Icons.play_arrow, size: 20,),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/landing' ,
                              arguments:  worldCupList!.list!.elementAt(index).name!);
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/ranking',
                              arguments: CommentVO(imgName: '이름', cupName: worldCupList!.list!.elementAt(index).name!, id: '', time: '', content: ''));
                        },
                        child: const Text('랭킹보기'),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon:const Icon(Icons.list, size: 20,),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/ranking' ,
                              arguments: CommentVO(imgName: '이름', cupName: worldCupList!.list!.elementAt(index).name!, id: '', time: '', content: ''));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}