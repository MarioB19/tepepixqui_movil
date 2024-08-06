import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

class ImageCarousel<T extends GetxController> extends StatelessWidget {
  final T controller;

  ImageCarousel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          var images = (controller as dynamic).images;
          return images.isEmpty
              ? Center(child: Text('No images selected.'))
              : CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    return Stack(
                      children: [
                        ExtendedImage.file(
                          images[index],
                          fit: BoxFit.cover,
                          mode: ExtendedImageMode.gesture,
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => (controller as dynamic).removeImage(index),
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
              
                    autoPlay: true,
                
                    enlargeCenterPage: true,
                  ),
                );
        }),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () => (controller as dynamic).addImage(),
          tooltip: 'Add Image',
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
