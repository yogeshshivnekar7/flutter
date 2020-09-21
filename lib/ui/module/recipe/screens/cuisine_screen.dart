import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/recipe/models/cuisine.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';

import '../widgets/grid_view_item.dart';

class CuisineScreen extends StatefulWidget {
  final List<Cuisine> _cuisine;

  CuisineScreen(this._cuisine);

  @override
  _CuisineScreenState createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  List<Cuisine> cuisine;

  @override
  Widget build(BuildContext context) {
    cuisine = widget._cuisine;
    return Column(
      children: <Widget>[
        Expanded(
          child: cuisine.length > 0
              ? GridView(
                  padding: const EdgeInsets.all(15),
                  children: cuisine
                      .map(
                        (catData) => GridViewItem(
                          catData.id,
                          catData.name,
                          catData.image,
                          HttpService.CUISINE_IMAGES_PATH,
                          text_colors: "white",
                        ),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
