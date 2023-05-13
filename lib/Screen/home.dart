import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/Screen/widgets/CardScrollable.dart';
import 'package:task/Screen/widgets/carousel.dart';
import '../common_widgets/StarRating.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _imageList = [];
  var _bannerTitle = "";
  var _description = "";
  var _details = [];
  var popularTrek = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _imageList = data['bannerImages'];
      _bannerTitle = data['bannerTitle'];
      _description = data['description'];
      _details = data['details'];
      popularTrek = data['popularTreks'];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: const IconButton(
                    icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
                    onPressed: null,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: const IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: null,
                  ),
                )
              ],
            ),
            expandedHeight: 210.0,
            flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: FlexibleSpaceBar(
                  background:
                      Carousel(images: _imageList, bannerTitle: _bannerTitle),
                )),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: StarRating(
                      starCount: 5,
                      rating: 5,
                      color: Color.fromARGB(255, 255, 220, 24),
                      size: 30,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Text(
                  _description,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 56, 54, 54),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _details.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(),
                        child: ListTile(
                          leading: const Text("•",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 56, 54, 54))),
                          title: Text(
                            _details[index],
                            style: const TextStyle(
                                color: Color.fromARGB(255, 56, 54, 54)),
                          ),
                        ));
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Popular Treks",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
          CardScrollabel(popularTrek: popularTrek)
        ],
      ),
    );
  }
}
