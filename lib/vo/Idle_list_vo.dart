import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'Idle_vo.dart';
import 'dart:io';

class IdleList {
  List<Idle> _idleList = [];

  final firestore = FirebaseFirestore.instance;
  int _index = -1;


  ads(String cupName1) async{
    List<dynamic>? dd = [];
    await firestore.collection('category').where('cupName',isEqualTo: cupName1).get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        dd.add(doc.data());
      })
    }
    );
    print(dd.length);

    for(int i=2;i<dd.length;i++) {
      // print(dd[i]['cupName']);
      print(dd[i]['imgName']);
      String path = "images/" + dd[i]['cupName'] + "/" + dd[i]['imgName'] + ".jpg";
      //print(path);
      _idleList.add(Idle(path));
      print(_idleList[i].toString());
    }

    print(_idleList.length);

    _idleList.add( Idle("images/asd/end.jpg"));
    _idleList.add( Idle("images/asd/end.jpg"));
    print(_idleList.length);
    print(_idleList.toString());

  }


  IdleList(String s){
    ads(s);
    //  _idleList.add(zz());
    _idleList.isEmpty?print('asd'):print('2222222');
    print(_idleList.length.toString()+"ADS");
    if(s=='면요리') {
      _idleList.add(Idle("images/면요리/칼국수.jpg"));
      _idleList.add(Idle("images/면요리/쫄면.jpg"));
    }else if(s=='곤충'){
      _idleList.add(Idle("images/곤충/누에.jpg"));
      _idleList.add(Idle("images/곤충/모기.jpg"));
    }else if(s=='휴양지'){
      _idleList.add(Idle("images/휴양지/보라카이.jpg"));
      _idleList.add(Idle("images/휴양지/말레이시아.jpg"));
    }else if(s=='무인도도구'){
      _idleList.add(Idle("images/무인도도구/곰인형.jpg"));
      _idleList.add(Idle("images/무인도도구/생라면.jpg"));
    }else if(s=='과일'){
      _idleList.add(Idle("images/과일/포도.jpg"));
      _idleList.add(Idle("images/과일/딸기.jpg"));
    }else if(s=='귀여운동물'){
      _idleList.add(Idle("images/귀여운동물/수달.jpg"));
      _idleList.add(Idle("images/귀여운동물/펭귄.jpg"));
    }
  }

  List<Idle> get idle => _idleList;
  int get length => _idleList.length;

  Idle? get nextIdle {
    _index++;
    if (_index >= length) return null;
    return _idleList[_index];
  }

  bool get isEnd {
    if ((_index + 1) == length) {

      return true;
    } else {
      // if(_index == -1){
      //   _index=0;
      //   return true;
      // }
      print('${_index}+isEnd');
      return false;
    }
  }

  resetList( List<Idle> _winners ){
    _idleList = _winners;
    _idleList.add( Idle("images/휴양지/end.jpg"));
    _idleList.add( Idle("images/휴양지/end.jpg"));
    _index = -1;
  }

  get index => _index;

  winner(List<Idle> _winners){
    _idleList = _winners;
    print(_idleList.length);
    _index = -1;
  }

  void plus(String path) {
    _idleList.add(path as Idle);
  }

}