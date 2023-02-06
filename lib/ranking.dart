import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../vo/commentVO.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {

  CollectionReference category = FirebaseFirestore.instance.collection("category");
  CollectionReference comment = FirebaseFirestore.instance.collection("comment");

  @override
  Widget build(BuildContext context) {

    final args= ModalRoute.of(context)!.settings.arguments as CommentVO;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                  onPressed: (){
                    Navigator.popAndPushNamed(context, '/' );
                  }, child: const Text('메인')),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(args.cupName + ' 월드컵 랭킹 TOP5',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 7),
                        height: 440,
                        child: StreamBuilder(
                            stream: category.where("cupName", isEqualTo: args.cupName).orderBy('win', descending: true).limit(5).snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot){
                              if(streamSnapshot.hasData){
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index){
                                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                      return Card(
                                        margin: const EdgeInsets.only(left: 16, right: 16, top: 8 , bottom: 8),
                                        shape:
                                        ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side: BorderSide(width: 3.5, color: Colors.indigo.shade700),
                                        ),
                                        child: ListTile(
                                          title: Text('${index + 1}. '+ documentSnapshot['imgName']),
                                          subtitle: Text('우승횟수: ' + documentSnapshot['win'].toString()),
                                          trailing: SizedBox(
                                            // width: 200,
                                            child: FittedBox(
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'images/' + args.cupName + '/' + documentSnapshot['imgName'] + '.jpg',
                                                    width: 97,
                                                    height: 60,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator()
                              );
                            }
                        )
                    ),
                    Container(
                      height: 40,
                      width: double.maxFinite,
                      color: Colors.blue[100],
                      alignment: Alignment.center,
                      child: const Text('댓글',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                    Container(
                        height: 200,
                        child: StreamBuilder(
                            stream: comment.where("cupName", isEqualTo: args.cupName).orderBy('time', descending: true).snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot){
                              if(streamSnapshot.hasData){
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context,index){
                                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                      return Card(
                                        color: Colors.blue[50],
                                        margin: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2),
                                        child: ListTile(
                                          title: Text(documentSnapshot['id']),
                                          subtitle: Text(documentSnapshot['content']),
                                          trailing: SizedBox(
                                            width: 100,
                                            child: SingleChildScrollView(
                                              child: Row(
                                                children: [
                                                  Text(documentSnapshot['time'],
                                                    style: const TextStyle(
                                                        fontSize: 10
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator()
                              );
                            }
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

