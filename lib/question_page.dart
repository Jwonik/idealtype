import 'package:flutter/material.dart';
import 'package:idealtype/ui/round_bar.dart';
import 'package:idealtype/vo/Idle_list_vo.dart';
import 'package:idealtype/vo/Idle_vo.dart';
import '../ui/select_button.dart';
import '../ui/select_name.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPage extends StatefulWidget {

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  final IdleList _idleList = IdleList(Get.arguments);

  List<Idle> _winners08 = [];
  List<Idle> _winners04 = [];
  List<Idle> _winners02 = [];
  List<Idle> _lastWinner = [];

  late Idle _selectName;

  late Idle _name1;
  late Idle _name2;

  late bool _where;
  String round = "16강";
  bool overlayShouldBevisible = false;

  @override
  void initState() {
    super.initState();;
    _name1 = _idleList.nextIdle!;
    _name2 = _idleList.nextIdle!;
  }

  void handleSelect(Idle name, bool where) {
    _selectName = name;
    _where = where;
    setState(() {
      overlayShouldBevisible = true;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            //Text("휴양지 월드컵 "+ round,  style: const TextStyle(color: Colors.black, fontSize: 30)),
            RoundBar(Get.arguments+" 월드컵", round),
            SelectButton(true, _name1, () => handleSelect(_name1, true)),
            SelectButton(false, _name2, () => handleSelect(_name2, false)),
          ],
        ),

        overlayShouldBevisible == true
            ?  SelectName(_selectName, _idleList.isEnd, () {

          if(_winners02.length == 4) {
            _lastWinner.add(_selectName);
          }
          else if(_winners04.length == 6) {
            _winners02.add(_selectName);
          }
          else if(_winners08.length == 10) {
            _winners04.add(_selectName);
          }
          else if(_idleList.length == 18) {
            _winners08.add(_selectName);
          }


          if(_winners08.length == 8) {
            _idleList.resetList(_winners08);
            round = "8강";
          }
          if(_winners04.length == 4) {
            _idleList.resetList(_winners04);
            round = "4강";
          }
          if(_winners02.length == 2) {
            _idleList.winner(_winners02);
            round = "결승전";
          }
          if(_lastWinner.length == 1 ) {
            _idleList.resetList(_lastWinner);
            _lastWinner.removeLast();
            _lastWinner.removeLast();
            _idleList.index();
            return;
          }

          if (_idleList.isEnd == false) {
            setState(() {
              overlayShouldBevisible = false;
              if (_where == true) {
                _name1 = _idleList.nextIdle!;
                _name2 = _idleList.nextIdle!;
              } else {
                _name2 = _idleList.nextIdle!;
                _name1 = _idleList.nextIdle!;
              }
            });
            return;
          }
        })
            : Container(),
      ],
    );
  }
}

