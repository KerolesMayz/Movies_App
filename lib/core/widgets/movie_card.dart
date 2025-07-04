import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/data/local_services/local_history_service.dart';
import 'package:movies/data/models/profile_response/profile_data.dart';
import 'package:movies/data/models/watch_list_response/favourite_movie.dart';
import 'package:movies/screens/movie_details/movie_details.dart';

import '../colors_manager/colors_Manager.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    this.width,
    this.fit = BoxFit.fill,
    this.radius = 16,
    required this.id,
  });

  final String imageUrl;
  final dynamic rating;
  final double? width;
  final BoxFit fit;
  final double radius;
  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
           LocalHistoryService.saveVisitedMovie(
            FavouriteMovie(
              movieId: id,
              imageURL: imageUrl,
              rating: rating!,
              // Add more fields if your model needs
            ),
             ProfileData.userProfile!.id.toString(),
          );
          Navigator.push(context,
              CupertinoPageRoute(builder: (_) => MovieDetails(id: id,)));
        },
        child: SizedBox(
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image.network(
                    imageUrl,
                    fit: fit,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        alignment: Alignment.center,
                        width: width,
                        height: double.infinity,
                        color: Colors.black12,
                        child: const CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (_, _, _) =>
                        Container(
                          width: width,
                          height: double.infinity,
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const Icon(Icons.error, color: Colors.red),
                        )
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: REdgeInsets.all(14),
                  color: ColorsManager.black.withAlpha(75),
                  child: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          rating.toString(),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: ColorsManager.white,
                          ),
                        ),
                        Icon(Icons.star, color: ColorsManager.yellow,
                            size: 16.r),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
