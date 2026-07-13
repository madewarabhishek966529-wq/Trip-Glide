import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children:[
            ProfileHeader(),
            SizedBox(height:24),
            ProfileStats(),
            SizedBox(height:24),
            ProfileMenu(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget{
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context){
    return const Column(
      children:[
        CircleAvatar(radius:50,child:Icon(Icons.person,size:50)),
        SizedBox(height:12),
        Text('Abhishek',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
        Text('Flutter Developer'),
      ],
    );
  }
}

class ProfileStats extends StatelessWidget{
  const ProfileStats({super.key});
  @override
  Widget build(BuildContext context){
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        _Stat(title:'Trips',value:'12'),
        _Stat(title:'Favorites',value:'8'),
        _Stat(title:'Reviews',value:'20'),
      ],
    );
  }
}

class _Stat extends StatelessWidget{
  final String title,value;
  const _Stat({required this.title,required this.value});
  @override
  Widget build(BuildContext context)=>Column(children:[
    Text(value,style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
    SizedBox(height:4),
    Text(title),
  ]);
}

class ProfileMenu extends StatelessWidget{
  const ProfileMenu({super.key});
  @override
  Widget build(BuildContext context){
    return Column(children:[
      ListTile(leading:Icon(Icons.settings),title:Text('Settings')),
      ListTile(leading:Icon(Icons.favorite),title:Text('Favorites')),
      ListTile(leading:Icon(Icons.logout,color:Colors.red),title:Text('Logout')),
    ]);
  }
}
