import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../models/Categories.dart';
import '../models/ScreenArguements.dart';
import '../providers/CategoriesModel.dart';
import '../utils/my_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'CategoriesMediaScreen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesModel categoriesModel = Provider.of<CategoriesModel>(context);
    List<Categories>? items = categoriesModel.categories;
    if (categoriesModel.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, itemIndex, pageViewIndex) =>
                Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Color.fromARGB(197, 158, 158, 158),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20)))),
            options: CarouselOptions(
                autoPlayInterval: const Duration(seconds: 10),
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true)),
      );
    } else {
      return Container(
          width: double.infinity,
          height: 260,
          child: Column(children: [
            ListTile(
              title: Text('Categories',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primary)),
              // trailing: IconButton(
              //     onPressed: () => null, icon: Icon(Icons.arrow_forward))
            ),
            CarouselSlider.builder(
                itemCount: categoriesModel.categories!.length,
                itemBuilder: (context, itemIndex, pageViewIndex) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CategoriesMediaScreen.routeName,
                          arguments:
                              ScreenArguements(position: 0, items: items![itemIndex]),
                        );
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            items![itemIndex].thumbnailUrl!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                        placeholder: (context, url) => Center(
                                            child:
                                                CupertinoActivityIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                                child: Icon(
                                              Icons.error,
                                              color: Colors.grey,
                                            )))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items[itemIndex].title!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.primary)),
                              )
                            ],
                          )),
                    ),
                options: CarouselOptions(
                    autoPlayInterval: const Duration(seconds: 10),
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true))
          ]));
    }
  }
}
