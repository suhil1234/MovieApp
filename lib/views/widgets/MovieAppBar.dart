import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/Movie.dart';
import 'package:get/get.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
            stretch: true,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsetsDirectional.only(
                        start: 16.0, bottom: 16.0),
                    centerTitle: true,
                    title: Stack(
                      children: [
                        Text(
                          movie.title,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 18,
                               foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.black,),
                        ),
                         Text(
                          movie.title,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 18,
                               color: Colors.white
                               ),
                        ),
                      ],
                    ),
                    stretchModes: const <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    // ClipRRect added here for rounded corners
                    background: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: Hero(
                        tag : 'movieImage_${movie.id}',
                        child: Image.network(
                          movie.imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
          );
  }
}