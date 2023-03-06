import 'package:flutter/material.dart';

class Header extends SliverPersistentHeaderDelegate {
  Header({required this.isDisplayTitle});
  bool isDisplayTitle;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 50,
      color: !isDisplayTitle ? Colors.white : null,
      decoration: isDisplayTitle
          ? BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0.5))
            ])
          : null,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      !isDisplayTitle
                          ? const Text(
                              'Back',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
          isDisplayTitle
              ? const Positioned.fill(
                  child: Center(
                  child: Text(
                    'Popular list',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ))
              : Container(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
