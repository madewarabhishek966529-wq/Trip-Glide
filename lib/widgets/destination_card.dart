import 'package:flutter/material.dart';
class DestinationCard extends StatelessWidget{
final String title,image,country;
const DestinationCard({super.key,required this.title,required this.image,required this.country});
@override Widget build(BuildContext c)=>Card(clipBehavior:Clip.antiAlias,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),child:Stack(children:[Image.asset(image,height:260,width:260,fit:BoxFit.cover),Positioned(left:16,bottom:16,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(country,style:TextStyle(color:Colors.white70)),Text(title,style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.bold))]))]));
}
