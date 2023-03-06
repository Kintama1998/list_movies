import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_movie/features/movie_popular/manages/movie_manage.dart';
import 'package:list_movie/features/movie_popular/widgets/movie_item.dart';

import 'widgets/header.dart';

class MoviePopular extends StatefulWidget {
  const MoviePopular({super.key});

  @override
  State<MoviePopular> createState() => _MoviePopularState();
}

class _MoviePopularState extends State<MoviePopular> {
  final controller = ScrollController();
  late PopularMovieManage streams = PopularMovieManage();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels > 50) {
        streams.isChangeStatusHeader(true);
      } else {
        streams.isChangeStatusHeader(false);
      }
      if (controller.position.maxScrollExtent - controller.position.pixels <
              100 &&
          controller.position.atEdge) {
        streams.isChangeStatusLoadmore(true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    streams.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: () async {
                    streams.refreshListMovie();
                  },
                  child: CustomScrollView(
                    controller: controller,
                    slivers: [
                      StreamBuilder(
                          initialData: false,
                          stream: streams.streamHeader,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SliverPersistentHeader(
                                  pinned: true,
                                  delegate:
                                      Header(isDisplayTitle: snapshot.data));
                            }
                            return const SliverToBoxAdapter();
                          }),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                'Popular list',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: streams.streamMovie,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SliverToBoxAdapter(
                                  child: SizedBox(
                                      height: 400,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Đang tải dữ liệu ...',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )));
                            }
                            if (snapshot.hasData) {
                              return SliverPadding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                sliver: SliverGrid(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.61,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 24,
                                          crossAxisSpacing: 24),
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return MovieItem(
                                      movie: snapshot.data![index],
                                    );
                                  }, childCount: snapshot.data!.length),
                                ),
                              );
                            }
                            return const SliverToBoxAdapter();
                          }),
                      StreamBuilder(
                          stream: streams.streamLoadmore,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return const SliverPadding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                sliver: SliverToBoxAdapter(
                                    child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )),
                              );
                            }
                            return const SliverToBoxAdapter();
                          }),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
