import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Details extends StatefulWidget {
  const Details({ Key? key }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        
        leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Details'),
      ),
      body: Center(
        child: Text('Details'),
      ),
    );
  }
}