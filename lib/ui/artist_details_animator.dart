import 'package:flutter/material.dart';
import 'package:blurry_artist_details_page/data/mock_data.dart';
import 'package:blurry_artist_details_page/ui/artist_details_page.dart';

class ArtistDetailsAnimator extends StatefulWidget {
  @override
  _ArtistDetailsAnimatorState createState() => _ArtistDetailsAnimatorState();
}

class _ArtistDetailsAnimatorState extends State<ArtistDetailsAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 4200),
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtistDetailsPage(
      artist: MockData.andy,
      controller: _controller,
    );
  }
}
