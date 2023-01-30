import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';

class BgDecorationHelper{
 
 BoxDecoration chatBgDecoration(){
  return  BoxDecoration(image: DecorationImage(image: AssetImage(ImageUtils.CHAT_BG),
              fit: BoxFit.fill
              ),);
 }



}