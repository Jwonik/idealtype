import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:idealtype/vo/commentVO.dart';
import 'dart:math';
import '../landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../vo/Idle_vo.dart';

class SelectName extends StatefulWidget {
  final Idle _name;
  final VoidCallback _onTap;
  final bool _last;
  SelectName(this._name, this._last, this._onTap);

  @override
  _SelectNameState createState() => _SelectNameState();
}

class _SelectNameState extends State<SelectName>
    with SingleTickerProviderStateMixin {
  late Animation<double> _ani;
  late AnimationController _aniC;
  final firestore = FirebaseFirestore.instance;
  CollectionReference category = FirebaseFirestore.instance.collection('category');
  List<dynamic> dd = [];
  String cc='';
  @override
  void initState() {
    super.initState();

    _aniC = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _ani = CurvedAnimation(parent: _aniC, curve: Curves.elasticOut);
    _ani.addListener(() => this.setState(() => {}));
    _aniC.forward();
  }

  @override
  void dispose() {
    _aniC.dispose();
    super.dispose();
  }

  upwin() async{

    String mm = widget._name.name.split("/")[2].split('.')[0];
    await firestore.collection('category').where('imgName',isEqualTo: mm).get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) async {
        dd.add(doc.id);
        print(mm);
        String cc = dd.toString().split('[')[1].split(']')[0];
        print(cc);
        await category.doc(cc).update({'win':FieldValue.increment(1)});
      })
    }
    );


    print(dd.length);
    print(dd.toString());
    print('adssadasdas');
  }



  @override
  Widget build(BuildContext context) {
    if (widget._last == false) {
      return Material(
        color: Colors.black54,
        child: InkWell(
          onTap: () => widget._onTap(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: _aniC.value * 2 * pi,
                    child: Icon(
                      Icons.done,
                      size: _aniC.value * 80.0,
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              Text(
                widget._name.name.split("/")[2].split('.')[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Material(
        color: Colors.red,
        child: Transform.scale(
          scale: _aniC.value * 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "우승",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
              Image.asset(widget._name.name, width: 220, height: 180,),
              Text(
                widget._name.name.split("/")[2].split('.')[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: Colors.white,
                  iconSize: 50.0,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/winner',
                        arguments: CommentVO(
                            imgName: widget._name.name.split("/")[2].split('.')[0],
                            cupName: widget._name.name.split("/")[1],
                            id: '', time: '', content: ''));
                    upwin();
                  }
              ),
            ],
          ),
        ),
      );
    }
  }
}
