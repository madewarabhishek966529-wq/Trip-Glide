import 'package:flutter/material.dart';
class CustomBottomNavBar extends StatelessWidget{
final int index;final ValueChanged<int> onTap;
const CustomBottomNavBar({super.key,required this.index,required this.onTap});
@override Widget build(BuildContext c)=>NavigationBar(selectedIndex:index,onDestinationSelected:onTap,destinations:const[
NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:''),
NavigationDestination(icon:Icon(Icons.favorite_border),selectedIcon:Icon(Icons.favorite),label:''),
NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:''),
]);}
