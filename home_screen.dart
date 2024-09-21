import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String destination = '';
  String travelDate = '';

  void _findTravelBuddies() async {
    // Search for travelers going to the same destination and date
    QuerySnapshot buddies = await _firestore
        .collection('travelers')
        .where('destination', isEqualTo: destination)
        .where('travelDate', isEqualTo: travelDate)
        .get();

    // Just print out the number of travelers found for now
    print('Found ${buddies.docs.length} travelers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Travel Buddies')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) => destination = value,
              decoration: InputDecoration(labelText: 'Destination'),
            ),
            TextField(
              onChanged: (value) => travelDate = value,
              decoration: InputDecoration(labelText: 'Travel Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Find Buddies'),
              onPressed: _findTravelBuddies,
            ),
          ],
        ),
      ),
    );
  }
}
