import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';

import '../widgets/grid_view_item.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories-screen';

  final List<Category> categories;

  CategoriesScreen({this.categories});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories;

  @override
  Widget build(BuildContext context) {
    categories = widget.categories;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: categories.length > 0
                  ? GridView(
                      padding: const EdgeInsets.all(15),
                      children: categories
                          .map(
                            (catData) => GridViewItem(
                              catData.id,
                              catData.name,
                              catData.image,
                              HttpService.CATEGORY_IMAGES_PATH,
                              text_colors: 'black',
                            ),
                          )
                          .toList(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200, // width of each item
                        childAspectRatio: 3 / 2, // can be 1.5
                        crossAxisSpacing:
                            15, // padding between items horizontally
                        mainAxisSpacing: 15, // padding between items vertically
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
