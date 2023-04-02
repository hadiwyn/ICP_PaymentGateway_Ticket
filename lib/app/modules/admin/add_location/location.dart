// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddLocationScreen extends StatefulWidget {
//   @override
//   _AddLocationScreenState createState() => _AddLocationScreenState();
// }

// class _AddLocationScreenState extends State<AddLocationScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   LatLng _selectedLocation = LatLng(37.42796133580664, -122.085749655962);

//   void _selectLocation(LatLng position) {
//     setState(() {
//       _selectedLocation = position;
//     });
//   }

//   void _saveLocation() async {
//     final locationData = {
//       'latitude': _selectedLocation.latitude,
//       'longitude': _selectedLocation.longitude
//     };

//     await _firestore.collection('locations').add(locationData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Location'),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(37.42796133580664, -122.085749655962),
//                 zoom: 14.4746,
//               ),
//               onTap: _selectLocation,
//               markers: _selectedLocation == null
//                   ? {}
//                   : {
//                       Marker(
//                         markerId: MarkerId('m1'),
//                         position: _selectedLocation,
//                       ),
//                     },
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: _selectedLocation == null ? null : _saveLocation,
//             child: Text('Save Location'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AddScreenLocation extends StatelessWidget {
  const AddScreenLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Location"),
        actions: const [],
      ),
      body: Center(
        child: Text("Pengembangan"),
      ),
    );
  }
}
