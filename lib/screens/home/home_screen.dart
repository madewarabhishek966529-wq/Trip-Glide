import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('TripGlide')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SearchSection(),
            SizedBox(height:16),
            CategoryList(),
            SizedBox(height:16),
            Expanded(child: DestinationList()),
          ],
        ),
      ),
    );
  }
}

class SearchSection extends StatelessWidget{
  const SearchSection({super.key});
  @override
  Widget build(BuildContext context)=>const TextField(decoration:InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search destination'));
}

class CategoryList extends StatelessWidget{
  const CategoryList({super.key});
  @override
  Widget build(BuildContext context)=>SizedBox(
    height:40,
    child:ListView(scrollDirection:Axis.horizontal,children:const[
      Chip(label:Text('Popular')),
      SizedBox(width:8),
      Chip(label:Text('Beach')),
      SizedBox(width:8),
      Chip(label:Text('Mountain')),
    ]),
  );
}

class DestinationList extends StatelessWidget{
  const DestinationList({super.key});
  @override
  Widget build(BuildContext context)=>ListView(
    scrollDirection:Axis.horizontal,
    children:const[
      FeaturedCard(title:'Rio de Janeiro'),
      SizedBox(width:16),
      FeaturedCard(title:'Paris'),
    ],
  );
}

class FeaturedCard extends StatelessWidget{
  final String title;
  const FeaturedCard({super.key,required this.title});
  @override
  Widget build(BuildContext context)=>Container(
    width:260,
    decoration:BoxDecoration(
      borderRadius:BorderRadius.circular(24),
      color:Colors.blueGrey,
    ),
    child:Align(
      alignment:Alignment.bottomLeft,
      child:Padding(
        padding:EdgeInsets.all(16),
        child:Text(title,style:TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.bold)),
      ),
    ),
  );
}
