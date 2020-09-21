import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/utils/util.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

class HomeRecipeItem extends StatefulWidget {
  final List<Recipe> recipe;
  final int index;
  final String path;

  HomeRecipeItem({this.recipe, this.index, this.path});

  @override
  _HomeRecipeItemState createState() => _HomeRecipeItemState();
}

class _HomeRecipeItemState extends State<HomeRecipeItem> {
  String userPath = HttpService.USER_IMAGES_PATH;

  @override
  void initState() {
    super.initState();
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(
          id: widget.recipe[widget.index].id,
          name: widget.recipe[widget.index].name,
          image: widget.recipe[widget.index].image,
          duration: widget.recipe[widget.index].duration,
          serving: widget.recipe[widget.index].serving,
          difficulty: widget.recipe[widget.index].difficulty,
          cuisine: widget.recipe[widget.index].cuisine,
          categories: widget.recipe[widget.index].categories,
          ingredients: widget.recipe[widget.index].ingredients,
          steps: widget.recipe[widget.index].steps,
          fName: widget.recipe[widget.index].fname,
          lName: widget.recipe[widget.index].lname,
          userImage: widget.recipe[widget.index].userimage,
          date: widget.recipe[widget.index].date,
          userId: widget.recipe[widget.index].userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var total2 = widget.recipe[widget.index].total;
    return InkWell(
      onTap: () => selectMeal(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl:
                        '${widget.path}${widget.recipe[widget.index].image}' +
                            "?dummy=0",
                        placeholder: (context, url) => ShimmerWidget(
                          width: 90,
                          height: 80,
                          circular: false,
                        ),
                        width: 90,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            child: AutoSizeText(
                              widget.recipe[widget.index].name,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed', fontSize: 18),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              children: [
                                total2 == null
                                    ? Container()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 0, 0),
                                            child: Icon(
                                              Icons.star,
                                              size: 20,
                                              color: FsColor.primaryrecipe,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 2, 0, 0),
                                            child: Text(
                                                total2 == null ? "0" : total2),
                                          ),
                                        ],
                                      ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 2, 0, 0),
                                  child: Text(
                                    Util.getDuration(
                                        widget.recipe[widget.index].duration),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  child: Text(
                                    widget.recipe[widget.index].difficulty,
                                    style: TextStyle(
                                        color: FsColor.primaryrecipe,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                            child: Row(
                              children: [
                                (widget.recipe[widget.index].userimage != null)
                                    ? (widget.recipe[widget.index].userimage
                                    .contains(
                                    'https://platform-lookaside.fbsbx.com') ||
                                    widget
                                        .recipe[widget.index].userimage
                                        .contains(
                                        'https://lh3.googleusercontent.com'))
                                    ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${widget.recipe[widget.index].userimage}'),
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                )
                                    : CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(url2()),
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                )
                                    : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      'assets/images/logo_user.png'),
                                  radius: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '${widget.recipe[widget.index].fname} ${widget.recipe[widget.index].lname}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ]),
      ),
    );
  }

  String url2() {
    String s = '$userPath${widget.recipe[widget.index].userimage}?dummy=0';
    return s;
  }
}
