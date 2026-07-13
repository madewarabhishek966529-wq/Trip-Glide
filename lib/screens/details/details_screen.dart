import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget{
 const DetailsScreen({super.key});

 @override
 Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Destination')),
    body: const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Gallery(),
          SizedBox(height:20),
          InfoSection(),
          SizedBox(height:20),
          AboutSection(),
          SizedBox(height:20),
          ReviewList(),
          SizedBox(height:24),
          BookingButton(),
        ],
      ),
    ),
  );
 }
}

class Gallery extends StatelessWidget{
 const Gallery({super.key});
 @override
 Widget build(BuildContext context)=>Container(
   height:260,
   decoration:BoxDecoration(
     borderRadius:BorderRadius.circular(24),
     color:Colors.grey.shade300,
   ),
   child:const Center(child:Icon(Icons.image,size:70)),
 );
}

class InfoSection extends StatelessWidget{
 const InfoSection({super.key});
 @override
 Widget build(BuildContext context)=>const Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children:[
     Text('Rio de Janeiro',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
     SizedBox(height:8),
     Text('Brazil • ⭐ 5.0 (143 reviews)')
   ],
 );
}

class AboutSection extends StatelessWidget{
 const AboutSection({super.key});
 @override
 Widget build(BuildContext context)=>const Text(
 'Rio de Janeiro is known for its beaches, mountains, Carnival festival, and iconic Christ the Redeemer statue.',
 style:TextStyle(height:1.6),
 );
}

class ReviewList extends StatelessWidget{
 const ReviewList({super.key});
 @override
 Widget build(BuildContext context)=>Column(
   children: const[
     ListTile(leading:CircleAvatar(child:Icon(Icons.person)),title:Text('John'),subtitle:Text('Amazing destination!')),
     ListTile(leading:CircleAvatar(child:Icon(Icons.person)),title:Text('Emily'),subtitle:Text('Loved the experience.')),
   ],
 );
}

class BookingButton extends StatelessWidget{
 const BookingButton({super.key});
 @override
 Widget build(BuildContext context)=>SizedBox(
   width:double.infinity,
   child:ElevatedButton(
     onPressed:(){},
     child:const Text('Book Now'),
   ),
 );
}
