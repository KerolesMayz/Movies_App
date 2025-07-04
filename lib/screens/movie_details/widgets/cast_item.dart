import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movie_details_response/movie_cast.dart';

class CastItem extends StatelessWidget {
  const CastItem({super.key, required this.movieCast});

  final MovieCast movieCast;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movieCast.urlSmallImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(movieCast.urlSmallImage!, fit: BoxFit.fill),
            )
          : Icon(Icons.error, size: 60.r),
      title: Text('Name : ${movieCast.name}'),
      subtitle: Text('Character : ${movieCast.characterName}'),
    );
  }
}
