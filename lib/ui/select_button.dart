import 'package:flutter/material.dart';
import '../vo/Idle_vo.dart';

class SelectButton extends StatelessWidget {
  final bool _where;
  final Idle _name;
  final VoidCallback _onTap;

  SelectButton(this._where, this._name, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Material(
          color: _where == true ? const Color.fromRGBO(252, 237, 138, 1) : const Color.fromRGBO(56, 219, 238, 1),
          child: InkWell(
            onTap: () => _onTap(),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5.0),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(_name.name, width: 400, height: 320,),
                  ),
                  Positioned(
                    bottom: 14,
                    width: 390,
                    child: Container(
                      child: Text(_name.name.split("/")[2].split('.')[0], textAlign: TextAlign.center, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
