import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint/drawing_area.dart';

class Draw extends CustomPainter{
  List<DrawingArea> coordinates;

  Draw({@required this.coordinates});


  @override
  void paint(Canvas canvas, Size size) {

   for(int x=0;x<coordinates.length -1 ;x++)
     {
       if(coordinates[x]!=null && coordinates[x+1]!=null){
         Paint paint = coordinates[x].areaPaint;
         canvas.drawLine(coordinates[x].coordinate,coordinates[x+1].coordinate, paint);
       }
       else if(coordinates[x]!=null && coordinates[x+1]==null){
         Paint paint = coordinates[x].areaPaint;
         canvas.drawPoints(PointMode.points,[coordinates[x].coordinate], paint);
       }
     }

  }

  @override
  bool shouldRepaint(Draw oldDelegate) => oldDelegate.coordinates!=coordinates;
}
