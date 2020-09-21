import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_edit_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/utils/util.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

class MyRecipesRecipeItem extends StatelessWidget {
  final List<Recipe> recipe;
  final int index;
  final String path;
  final Function getRecipes;

  MyRecipesRecipeItem({this.recipe, this.index, this.path, this.getRecipes});

  void selectRecipe(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(
          id: recipe[index].id,
          name: recipe[index].name,
          image: recipe[index].image,
          duration: recipe[index].duration,
          serving: recipe[index].serving,
          difficulty: recipe[index].difficulty,
          cuisine: recipe[index].cuisine,
          categories: recipe[index].categories,
          ingredients: recipe[index].ingredients,
          steps: recipe[index].steps,
          fName: recipe[index].fname,
          lName: recipe[index].lname,
          userImage: recipe[index].userimage,
          userId: recipe[index].userId,
          date: recipe[index].date,
        ),
      ),
    );
  }

  void editRecipe(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditRecipeScreen(
          id: recipe[index].id,
          name: recipe[index].name,
          image: recipe[index].image,
          duration: recipe[index].duration,
          serving: recipe[index].serving,
          difficulty: recipe[index].difficulty,
          cuisine: recipe[index].cuisine,
          categories: recipe[index].categories,
          ingredients: recipe[index].ingredients,
          steps: recipe[index].steps,
          fname: recipe[index].fname,
          lname: recipe[index].lname,
          userimage: recipe[index].userimage,
          userid: recipe[index].userId,
          date: recipe[index].date,
          getRecipes: getRecipes,
        ),
      ),
    );
  }

  Future<void> deleteRecipe(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Delete Recipe?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text("Are you sure you want to delete recipe  ?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  await HttpService.deleteUserRecipe(id);
                  await getRecipes();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var total2 = recipe[index].total;
    print("Rating :$total2");
    return InkWell(
      onTap: () => selectRecipe(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 90,
        width: double.infinity,
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: '$path${recipe[index].image}',
                    placeholder: (context, url) => ShimmerWidget(
                      width: 85,
                      height: 75,
                      circular: false,
                    ),
                    width: 85,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        recipe[index].name,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: <Widget>[
                        total2 == null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                      color: FsColor.primaryrecipe,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 2, 0, 0),
                                    child: Text(total2 == null ? "0" : total2),
                                  ),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                          child: Text(
                            Util.getDuration(recipe[index].duration),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        recipe[index].difficulty,
                        style: TextStyle(
                            color: FsColor.primaryrecipe,
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        recipe[index].date.substring(0, 10),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await deleteRecipe(context, recipe[index].recipeid);
                },
                child: Icon(
                  Icons.delete,
                  color: FsColor.primaryrecipe,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => editRecipe(context),
                child: Icon(
                  Icons.edit,
                  color: FsColor.primaryrecipe,
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
}
