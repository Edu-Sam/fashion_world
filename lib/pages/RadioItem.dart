import 'package:flutter/material.dart';
class RadioItem extends StatelessWidget{
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {

    return new Container(
        margin: new EdgeInsets.all(15.0),
        // shape: new CircleBorder()
        child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                height: 40.0,
                width: 80.0,
                child: new Center(
                    child: new Text(_item.text,style: new TextStyle(
                        color:
                        _item.isSelected ? Colors.white : Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0))),
                decoration: new BoxDecoration(
                    color: _item.isSelected
                        ? Color.fromRGBO(2,127,255,0.7)
                        : Color.fromRGBO(241, 242, 244, 1),
                    borderRadius: const BorderRadius.all(const Radius.circular(100)),
                    border: new Border.all(
                        width: 0.0,
                        color: _item.isSelected
                            ? Color.fromRGBO(2,127,255,0.7)
                            : Color.fromRGBO(241, 242, 244, 1))

                ),

              ),

              /*    new Container(
              margin: new EdgeInsets.only(left: 10.0),
              child: new Text(_item.text),
            )*/
            ])
    );
  }

}

class RadioModel{
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected,this.buttonText,this.text);
}