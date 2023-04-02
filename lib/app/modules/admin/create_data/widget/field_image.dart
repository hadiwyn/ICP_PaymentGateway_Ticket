import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/create_data/index.dart';

class FieldImage extends StatefulWidget {
  const FieldImage({Key? key}) : super(key: key);

  @override
  _FieldImageState createState() => _FieldImageState();
}

class _FieldImageState extends State<FieldImage> {
  String _error = 'No Error Detected';
  List<Asset> images = [];

  ValueNotifier<String> dataNotifier = ValueNotifier<String>('Initial Value');

  var imageUrl = '';

  bool _isLoading = false;

  @override
  void initState() {
    loadAssets();
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(8.0), // Tambahkan properti padding di sini
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Padding(
          padding: EdgeInsets.all(8.0), // Tambahkan padding di sini
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 9, bottom: 9),
            child: InkWell(
              onTap: () async {
                uploadImages();
                if (imageUrl == null) {
                  // Jika imageUrl null, tampilkan CircularProgressIndicator
                  setState(() async {
                    _isLoading = true;
                  });
                  await Future.delayed(
                      Duration(seconds: 2)); // Simulasikan loading
                  setState(() {
                    _isLoading = false;
                  });
                } else {
                  print(imageUrl);
                  await Future.delayed(Duration(seconds: 10));
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Info'),
                        content: Text("Gambar berhasil disimpan"),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: () {
                              dataNotifier.value = 'data baru';
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      blurRadius: 6,
                      color: Color(0x34000000),
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Icon(Icons.save, color: Colors.black),
                    Spacer(),
                    Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: buildGridView(),
          ),
        ],
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "WisataKu",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _error = error;
      images = resultList;
    });
  }

  Future<void> uploadImages() async {
    List<String> imageUrls = [];
    Reference storageRef = FirebaseStorage.instance.ref().child("images");

    for (Asset imageAsset in images) {
      ByteData byteData = await imageAsset.getByteData();
      Uint8List imageData = Uint8List.fromList(byteData.buffer.asUint8List());

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference uploadRef = storageRef.child(fileName);

      try {
        await uploadRef.putData(imageData);

        String imageUrl = await uploadRef.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print(e);
      }
    }

    // Buat data baru dengan field sesuai jumlah url gambar yang diupload
    Map<String, dynamic> data = {};
    for (int i = 0; i < imageUrls.length; i++) {
      data['image_${i + 1}'] = imageUrls[i];
    }

    // Simpan data ke Firestore
    try {
      await FirebaseFirestore.instance.collection('wisata').add(data);
    } catch (e) {
      print(e);
    }
  }
}
