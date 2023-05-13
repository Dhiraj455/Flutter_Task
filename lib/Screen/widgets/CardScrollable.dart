import 'package:flutter/material.dart';

import '../../common_widgets/StarRating.dart';

class CardScrollabel extends StatelessWidget {
  final List popularTrek;
  const CardScrollabel({super.key, required this.popularTrek});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
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
                            image:
                                NetworkImage(popularTrek[index]["thumbnail"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
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
                                    color: Color.fromARGB(255, 255, 220, 24),
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
    );
  }
}
