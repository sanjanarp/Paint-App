import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:paint/draw.dart';
import 'package:paint/drawing_area.dart';

class PaintScreen extends StatefulWidget {
  @override
  _PaintScreenState createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  List<DrawingArea> coordinates = [];
  Color selectedColor;
  double strokeWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedColor = Colors.black;
    strokeWidth = 2.0;
  }

  void selectColor() {
    showDialog(
        context: context,
       child: AlertDialog(
         title: const Text("Color Chooser"),
         content: SingleChildScrollView(
           child: BlockPicker(
             pickerColor: selectedColor,
             onColorChanged: (color){
               setState(() {
                 selectedColor=color;
               });
             },
           ),
         ),
         actions: <Widget>[
           FlatButton(
               onPressed: () {
                 Navigator.of(context).pop();
               },
               child: Text("Close"))
         ],
       )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's paint!!"),
        actions: <Widget>[
          FlatButton(
              child: Row(
                children: [
                  Text("Clear", style: TextStyle(color: Colors.white),),
                  Icon(Icons.delete, color: Colors.white,),
                ],
              ),
              onPressed: () => coordinates.clear(),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                child: GestureDetector(
                 onPanDown: (details) {
                    setState(() {
                      coordinates.add(
                          DrawingArea(
                          coordinate:details.localPosition,
                          areaPaint: Paint()
                            ..strokeCap = StrokeCap.round
                            ..isAntiAlias = true
                            ..color = selectedColor
                            ..strokeWidth = strokeWidth
                      ),
                      );
                    });
                  },
                  onPanUpdate: (details) {
                    /*setState(() {
                      RenderBox object = context.findRenderObject();
                      Offset _localPosition = object.globalToLocal(details.globalPosition);
                      _coordinates = List.from(_coordinates)..add(_localPosition);
                    });*/
                    setState(() {
                      coordinates.add(
                        DrawingArea(
                            coordinate:details.localPosition,
                            areaPaint: Paint()
                              ..strokeCap = StrokeCap.round
                              ..isAntiAlias = true
                              ..color = selectedColor
                              ..strokeWidth = strokeWidth
                        ),
                      );
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      coordinates.add(null);
                    });
                  },
                  child: CustomPaint(
                    painter: Draw(coordinates:coordinates),
                    size: Size(double.infinity, 650),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Center(
              child: Container(
                width:400,
                decoration: BoxDecoration(
                   gradient: LinearGradient(
                     colors: [
                       Color.fromRGBO(142, 134, 214, 1),
                       Color.fromRGBO(249, 134, 134, 1),
                       Color.fromRGBO(169, 244, 234, 1),
                     ],
                     begin:Alignment.bottomRight,
                     end: Alignment.topLeft,
                   )
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.color_lens, color: selectedColor,), onPressed: (){
                      selectColor();
                    }),
                    Expanded(child: Slider(
                        min: 1.0,
                        max: 7.0,
                        inactiveColor: Colors.black54,
                        activeColor: selectedColor,
                        value: strokeWidth,
                        onChanged: (value){
                          setState(() {
                            strokeWidth = value;
                          });
                        }))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

