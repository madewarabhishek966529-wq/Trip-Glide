import 'dart:ui';import 'package:flutter/material.dart';
class GlassCard extends StatelessWidget{final Widget child;const GlassCard({super.key,required this.child});
@override Widget build(BuildContext c)=>ClipRRect(borderRadius:BorderRadius.circular(20),child:BackdropFilter(filter:ImageFilter.blur(sigmaX:12,sigmaY:12),child:Container(padding:EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white.withOpacity(.2)),child:child)));
}
