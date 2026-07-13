import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget{
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context){
    final favorites=<String>['Rio de Janeiro','Paris'];

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const EmptyFavorite()
          : FavoriteList(items:favorites),
    );
  }
}

class FavoriteList extends StatelessWidget{
  final List<String> items;
  const FavoriteList({super.key,required this.items});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder:(context,index){
        return Card(
          child: ListTile(
            leading: const Icon(Icons.favorite,color: Colors.red),
            title: Text(items[index]),
            trailing: const Icon(Icons.arrow_forward_ios,size:16),
          ),
        );
      },
    );
  }
}

class EmptyFavorite extends StatelessWidget{
  const EmptyFavorite({super.key});

  @override
  Widget build(BuildContext context){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Icon(Icons.favorite_border,size:90,color:Colors.grey),
          SizedBox(height:20),
          Text('No Favorites Yet',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
          SizedBox(height:8),
          Text('Save your dream destinations here.')
        ],
      ),
    );
  }
}
