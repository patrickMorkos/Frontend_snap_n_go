import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    Key? key,
    required this.items,
  }) : super(key: key);
  final List<Widget> items;
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final themeMode = ValueNotifier(2);

  @override
  Widget build(BuildContext context) {
    var screenSize=MediaQuery.of(context).size;
    return CarouselSlider(
   items: widget.items,
   options: CarouselOptions(
      height: screenSize.height/2,
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
   )
 );
  }
}