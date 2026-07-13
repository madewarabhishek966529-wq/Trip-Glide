import 'package:flutter/material.dart';
class CategoryChip extends StatelessWidget{
final String title;final bool selected;
const CategoryChip({super.key,required this.title,this.selected=false});
@override Widget build(BuildContext c)=>Chip(label:Text(title),backgroundColor:selected?Colors.black:Colors.grey.shade200,labelStyle:TextStyle(color:selected?Colors.white:Colors.black));
}
