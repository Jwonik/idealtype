import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idealtype/vo/commentVO.dart';
import 'package:get/get.dart';
class Winner extends StatefulWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  _WinnerState createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {

  final TextEditingController _namecontroller=
  TextEditingController(text: '익명');
  final TextEditingController _contentcontroller =
  TextEditingController();
  // final dbcontrol = DBControll();
  CollectionReference comment = FirebaseFirestore.instance.collection('comment');

  final firestore = FirebaseFirestore.instance;
  final TextEditingController _upcontentcontroller = TextEditingController();
  final TextEditingController _upnamecontroller = TextEditingController();
  String timeid = '';


  Future<void> _update(DocumentSnapshot documentSnapshot) async{
    _upnamecontroller.text=documentSnapshot['id'];
    _upcontentcontroller.text=documentSnapshot['content'];

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context1){
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,left: 20,right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _upnamecontroller,
                  decoration: const InputDecoration(
                      labelText: '닉네임',
                      enabled: false
                  ),
                ),
                TextField(
                  controller: _upcontentcontroller,
                  decoration: const InputDecoration(
                      labelText: "내용"
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async{
                          final String id = _upnamecontroller.text;
                          final String content = _upcontentcontroller.text;
                          comment.doc(documentSnapshot.id).update(
                              {'content':content,'id':id,'time':DateTime.now().toString().substring(0,19)}
                          );
                          timeid=DateTime.now().toString().substring(0,19);

                          _namecontroller.text='익명';
                          _contentcontroller.text='';
                          Navigator.of(context).pop();
                        },
                        child: const Text('수정')
                    ),
                    ElevatedButton(
                        onPressed: (){
                          comment.doc(documentSnapshot.id).delete();
                          Navigator.of(context).pop();
                        },
                        child: const Text('삭제')
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args= ModalRoute.of(context)!.settings.arguments as CommentVO;
    // String cupName1=args.cupName;
    // String imgName1 = args.imgName;

    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Text(args.cupName + " 월드컵 우승!!",
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 10.0,top: 20),
                  child: Image.asset('images/'+args.cupName+'/'+args.imgName+'.jpg'),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0,left: 0.0),
                  child: Text(args.imgName,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.popAndPushNamed(context, '/landing',
                          arguments: args.cupName);
                    },
                    child: const Text('다시')
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.popAndPushNamed(context, '/ranking',
                          arguments:  CommentVO(imgName: args.imgName, cupName: args.cupName, id: '', time: '', content: ''));},
                    child: const Text('랭킹')
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.popAndPushNamed(context, '/');
                    },
                    child: const Text('메인')
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.blue[100],
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 40),
                  child: const Text(
                    '댓글',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.overline,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0,top: 20.0),
                  height: 60,
                  width: 150,
                  child: (
                      TextField(
                        controller: _namecontroller,
                        maxLength: 6,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: '닉네임(기본 익명)',
                            border: OutlineInputBorder()
                        ),
                      )
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                  child: (
                      TextField(
                        controller: _contentcontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        maxLength: 50,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: '댓글을 입력해주세요',
                            border: OutlineInputBorder()
                        ),
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                  child: (
                      ElevatedButton(
                        onPressed: (){
                          _namecontroller.text.isEmpty||_contentcontroller.text.isEmpty?
                          _showdialog1(context)
                              :
                          _showdialog2(context,args.cupName,args.imgName);

                        },
                        child: const Text('작성'),
                      )
                  ),
                ),
                Container(
                    height: 400,
                    child: StreamBuilder(
                        stream: firestore.collection('comment').where('cupName',isEqualTo: args.cupName).orderBy('time',descending: true).snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot){
                          if(streamSnapshot.hasData){
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: streamSnapshot.data!.docs.length,
                                itemBuilder: (context,index){
                                  // final num leng = streamSnapshot.data!.docs.length;
                                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                  return Card(
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 5.0,
                                    color: Colors.blue[50],
                                    margin: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                    child: ListTile(
                                      title: Text(documentSnapshot['id']),
                                      subtitle: Text(documentSnapshot['content']),
                                      trailing: SizedBox(
                                        width: 100,
                                        child: SingleChildScrollView(child:
                                        Column(
                                          children: [
                                            Text(documentSnapshot['time'],
                                              style: const TextStyle(
                                                  fontSize: 10
                                              ),
                                            ),
                                            timeid==documentSnapshot['time']?
                                            IconButton(
                                                onPressed: () {
                                                  _update(documentSnapshot);
                                                },
                                                icon: const Icon(Icons.edit)
                                            ):
                                            Offstage(
                                              offstage: true,
                                              child: IconButton(
                                                  onPressed: () {
                                                    _update(documentSnapshot);
                                                  },
                                                  icon: const Icon(Icons.edit)
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
          ],
        ),
      ),

    );
  }

  Future<dynamic> _showdialog1(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text('asd'),
        content: const Text('빈칸 없이 입력해주세요.'),
        actions: [
          ElevatedButton(
              onPressed: () => {Navigator.of(context).pop(),
                _namecontroller.text='익명',_contentcontroller.clear()},
              child: const Text('닫기')),
        ],
      ),
    );
  }

  Future<dynamic> _showdialog2(BuildContext context,String cupName1,String imgName1) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text('asd'),
        content: const Text('작성완료'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                CommentVO;
                var covo = CommentVO(imgName: imgName1, cupName: cupName1,
                    id: _namecontroller.text+'('+imgName1+')', time: DateTime.now().toString().substring(0,19),
                    content: _contentcontroller.text);
                _namecontroller.text='익명';_contentcontroller.clear();

                firestore.collection('comment').add(covo.toMap());
                timeid=covo.time;
              },
              child: const Text('닫기')),
        ],
      ),
    );
  }
}
