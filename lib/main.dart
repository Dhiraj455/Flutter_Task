import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/Screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(top: false, child: Home()),
    );
  }
}

class CarouselApp extends StatefulWidget {
  const CarouselApp({super.key});

  @override
  State<CarouselApp> createState() => _CarouselAppState();
}

class _CarouselAppState extends State<CarouselApp> {
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
                    icon: Icon(Icons.arrow_back, color: Colors.black),
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
            expandedHeight: 200.0,
            flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: FlexibleSpaceBar(
                  background: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 1.0,
                    ),
                    items: _imageList.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    width: 200.0,
                                    child: Text(
                                      _bannerTitle,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          wordSpacing: 2,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ),
                                ),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                )),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
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
                          // leading: const Icon(Icons.circle_rounded, size: 10),
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
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 220,
                      child: Card(
                        child: Stack(
                          children: [
                            // The image covered by the card
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      popularTrek[index]["thumbnail"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: SizedBox(
                                    height: 50,
                                    // width: 0,
                                    child: Column(
                                      children: [
                                        Text(
                                          popularTrek[index]["title"],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const StarRating(
                                          starCount: 5,
                                          rating: 4,
                                          color:
                                              Color.fromARGB(255, 255, 220, 24),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            // The text overlapped at the bottom left
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: popularTrek.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;

  const StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = .0,
      required this.color,
      this.size = 24});

  @override
  // ignore: library_private_types_in_public_api
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return Icon(
          index < widget.rating.floor()
              ? Icons.star
              : index < widget.rating.ceil()
                  ? Icons.star_half
                  : Icons.star_outline,
          color: widget.color,
          size: widget.size,
        );
      }),
    );
  }
}
