import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget{
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState()=>_BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>{
  int guests=2;
  int selectedDate=15;
  String selectedTime='10:00 AM';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Book Tour')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateSelector(),
            const SizedBox(height:20),
            const TimeSelector(),
            const SizedBox(height:20),
            GuestCounter(
              guests: guests,
              onChanged:(v)=>setState(()=>guests=v),
            ),
            const Spacer(),
            const PriceSummary(price:560),
            const SizedBox(height:16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:(){},
                child: const Text('Confirm Booking'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateSelector extends StatelessWidget{
  const DateSelector({super.key});
  @override
  Widget build(BuildContext context)=>const ListTile(
    leading: Icon(Icons.calendar_month),
    title: Text('Select Date'),
    subtitle: Text('15 July'),
  );
}

class TimeSelector extends StatelessWidget{
  const TimeSelector({super.key});
  @override
  Widget build(BuildContext context)=>const ListTile(
    leading: Icon(Icons.access_time),
    title: Text('Time'),
    subtitle: Text('10:00 AM'),
  );
}

class GuestCounter extends StatelessWidget{
  final int guests;
  final ValueChanged<int> onChanged;
  const GuestCounter({super.key,required this.guests,required this.onChanged});

  @override
  Widget build(BuildContext context){
    return Row(
      children:[
        const Text('Guests'),
        const Spacer(),
        IconButton(onPressed:()=>onChanged(guests>1?guests-1:1),icon:const Icon(Icons.remove_circle_outline)),
        Text('$guests'),
        IconButton(onPressed:()=>onChanged(guests+1),icon:const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}

class PriceSummary extends StatelessWidget{
  final double price;
  const PriceSummary({super.key,required this.price});
  @override
  Widget build(BuildContext context)=>Card(
    child: ListTile(
      title: const Text('Total'),
      trailing: Text('\$${price.toStringAsFixed(0)}'),
    ),
  );
}
