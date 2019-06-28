import 'dart:ui' as ui;
import 'package:blurry_artist_details_page/data/models.dart';
import 'package:flutter/material.dart';
import 'package:blurry_artist_details_page/ui/video_card.dart';
import 'package:blurry_artist_details_page/ui/artist_details_enter_animations.dart';

class ArtistDetailsPage extends StatelessWidget {
  final Artist artist;
  final ArtistDetailsEnterAnimation animation;

  ArtistDetailsPage({
    @required this.artist,
    @required AnimationController controller,
  }) : animation = ArtistDetailsEnterAnimation(controller);

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: animation.backdropOpacity.value,
          child: Image.asset(
            artist.backdropPhoto,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: animation.backdropBlur.value,
            sigmaY: animation.backdropBlur.value,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Transform(
      transform: Matrix4.diagonal3Values(
        animation.avatarSize.value,
        animation.avatarSize.value,
        1.0,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 110.0,
        height: 110.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white30),
        ),
        margin: EdgeInsets.only(top: 32.0, left: 16.0),
        padding: EdgeInsets.all(3.0),
        child: ClipOval(
          child: Image.asset(artist.avatar),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            artist.firstName + '\n' + artist.lastName,
            style: TextStyle(
              color: Colors.white.withOpacity(animation.nameOpacity.value),
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Text(
            artist.location,
            style: TextStyle(
              color: Colors.white.withOpacity(animation.locationOpacity.value),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: EdgeInsets.symmetric(vertical: 16.0),
            width: animation.dividerWidth.value,
            height: 1.0,
          ),
          Text(
            artist.biography,
            style: TextStyle(
              color: Colors.white.withOpacity(animation.biographyOpacity.value),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoScroller() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Transform(
        transform: Matrix4.translationValues(
            animation.videoScrollerXTranslation.value, 0, 0),
        child: Opacity(
          opacity: animation.videoScrollerOpacity.value,
          child: SizedBox.fromSize(
            size: Size.fromHeight(245.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: artist.videos.length,
              itemBuilder: (context, index) {
                final video = artist.videos[index];

                return VideoCard(video);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AnimatedBuilder(
        animation: animation.controller,
        builder: _buildAnimation,
      ),
    );
  }
}
