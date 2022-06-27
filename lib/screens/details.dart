// import 'package:flutter/material.dart';

// import '../constants/colors.dart';
// import '../modals/testing_modal.dart';

// class Details extends StatefulWidget {
//   const Details({Key? key, required this.data}) : super(key: key);
//   final Data data;
//   @override
//   State<Details> createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 40,
//               backgroundImage: NetworkImage(widget.data.avatar!),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Text('${widget.data.firstName!}' + ' ' + '${widget.data.lastName!}'),
//             ), 
          
           
//             Text(widget.data.email!),
//           ],
//         ),
//       ),
//     );
//   }
// }
