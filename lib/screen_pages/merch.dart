import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maristcommerce/BottomNavBar/custom_scaffold.dart';

class Merch extends StatefulWidget {
  const Merch({super.key});

  @override
  State<Merch> createState() => _MerchState();
}

class _MerchState extends State<Merch> {
  List<String> imageUrls = [];
  List<String> titles = [
    'KEYCHAINS',
    'MUGS',
    'TUMBLRS',
    'UMBRELLA',
    'TOTEBAG',
  ];
  List<String> rating = [
    '4.5',
    '4.0',
    '3.5',
    '5.0',
    '4.2',
  ];
  List<String> subtitles = [
    'Organic',
    'Original',
    'TUMBLRS',
    'UMBRELLA',
    'TOTEBAG',
  ];
  List<String> pricing = [
    '\₱120',
    '\₱199',
    '\₱649',
    '\₱499',
    '\₱249',
  ];

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> fetchImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    for (int i = 1; i <= 5; i++) {
      try {
        Reference ref = storage.ref().child('m$i.jpg');
        String downloadUrl = await ref.getDownloadURL();
        if (!_isDisposed) {
          setState(() {
            imageUrls.add(downloadUrl);
          });
        }
      } catch (e) {
        if (!_isDisposed) {
          print('Error fetching image $i: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFF00BE62)),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: imageUrls.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageUrls[index],
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreenAccent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    titles[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    rating[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    subtitles[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    pricing[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
      showBottomNavBar: true,
      initalIndex: 1,
    );
  }
}

class MerchItem {
  final String image;
  final String title;
  final String subtitle;
  final double rating;
  final double price;

  MerchItem(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.rating,
      required this.price});
}
