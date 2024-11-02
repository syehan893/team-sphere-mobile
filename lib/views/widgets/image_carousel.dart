import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final Function(int index)? onTap;

  const ImageCarousel({
    super.key,
    required this.images,
    this.onTap,
  });

  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            itemCount: widget.images.length,
            physics: const BouncingScrollPhysics(),
            controller: PageController(
                initialPage: 0, viewportFraction: 0.85, keepPage: false),
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(index);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        PageViewDotIndicator(
          currentItem: currentIndex,
          count: widget.images.length,
          unselectedColor: Colors.grey,
          selectedColor: Colors.blue,
          size: const Size(24, 8),
          unselectedSize: const Size(8, 8),
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          alignment: Alignment.center,
          fadeEdges: false,
          boxShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
