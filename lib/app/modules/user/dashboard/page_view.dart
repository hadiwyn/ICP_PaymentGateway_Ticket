import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PageViewAutoSlide extends StatefulWidget {
  var detail;

  PageViewAutoSlide(this.detail, {super.key});

  @override
  State<PageViewAutoSlide> createState() => _PageViewAutoSlideState();
}

class _PageViewAutoSlideState extends State<PageViewAutoSlide> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('wisata')
          .doc(widget.detail['id'])
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Text('No data found');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;
        if (data == null) {
          return Text('Data is null');
        }

        final nImages = 2;

        List<String> imageUrls = [];
        for (int i = 1; i <= nImages; i++) {
          imageUrls.add(data['image_$i'] ?? '');
        }

        return PageView.builder(
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              child: Image.network(
                imageUrls[index],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
