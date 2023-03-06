import 'package:flutter/material.dart';
import 'package:list_movie/features/movie_popular/models/movie.dart';

class MovieItem extends StatelessWidget {
  MovieItem({super.key, required this.movie});
  Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 10,
            color: Colors.black87.withOpacity(0.7))
      ]),
      child: Stack(
        children: [
          //poster
          Positioned.fill(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
            ),
          )),
          //rate
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xffDD3763),
                      Color(0xffDD3763),
                      Color(0xffF38815),
                      Color(0xffF38815),
                      Color(0xffF38815)
                    ]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.voteAverage.toString().split('')[0].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  movie.voteAverage.toString().length >= 3
                      ? Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '.${movie.voteAverage.toString().split('')[2]}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          //info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                      tileMode: TileMode.clamp,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                      ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getYear(movie.releaseDate.toString()),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    formatTitle(movie.title.toString().toUpperCase()),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getYear(String date) {
    return date.split('-')[0];
  }

  String formatTitle(String title) {
    List<String> arr = title.split(' ');
    if (arr.length <= 2) return title;
    return '${arr[0]} ${arr[1]} \n${arr.getRange(2, arr.length).join(' ')}';
  }
}
