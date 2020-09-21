import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/profile_add_recipe_screen_2.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/my_recipes_recipe_item.dart';

import '../translation/app_localizations.dart';

class MyRecipesScreen extends StatefulWidget {
  final String id;

  MyRecipesScreen(this.id);

  @override
  _MyRecipesScreenState createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> {
  List<Recipe> recipes = List<Recipe>();
  String id;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipeById();
  }

  getRecipeById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('id') != null) {
      setState(() {
        id = prefs.getString('id');
      });
    } else {
      setState(() {
        id = prefs.getString('uid');
      });
    }
    await HttpService.getRecipesByUser(id).then((value) {
      setState(() {
        recipes = value;
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Recipes'.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileAddRecipeScreen(),
                ),
              );
              getRecipeById();
            },
          ),
        ],
      ),
      body: Container(
        child: (!isLoading)
            ? (recipes.isNotEmpty)
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      return MyRecipesRecipeItem(
                        recipe: recipes,
                        index: index,
                        path: HttpService.RECIPE_IMAGES_PATH,
                        getRecipes: getRecipeById,
                      );
                    },
                    itemCount: recipes == null ? 0 : recipes.length,
                  )
                : Center(
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('no_recent_recipes'),
                      style: GoogleFonts.pacifico(fontSize: 17),
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

//  void selectRecipe(BuildContext context, int index, List list) {
//    Navigator.of(context)
//        .push(
//      MaterialPageRoute(
//        builder: (context) => RecipeDetailsScreen(
//          id: list[index]['recipe_id'].toString(),
//          name: list[index]['recipe_name'],
//          image: list[index]['recipe_image'],
//          duration: list[index]['recipe_duration'],
//          serving: list[index]['recipe_serving'],
//          difficulty: list[index]['recipe_difficulty'],
//          cuisine: list[index]['recipe_cuisine'],
//          categories: list[index]['recipe_categories'],
//          ingredients: list[index]['recipe_ingredients'],
//          steps: list[index]['recipe_steps'],
//        ),
//      ),
//    )
//  }

//  Widget cookbookRecipeItem(
//      BuildContext context, List list, int index, String path) {
//    return InkWell(
//      onTap: () => selectRecipe(context, index, list),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        mainAxisSize: MainAxisSize.min,
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          ClipRRect(
//            borderRadius: BorderRadius.circular(10),
//            child: CachedNetworkImage(
//              imageUrl: '$path${list[index]['recipe_image']}',
//              placeholder: (context, url) =>
//                  ShimmerWidget(width: double.infinity, height: 130),
//              width: double.infinity,
//              height: 130,
//              fit: BoxFit.cover,
//            ),
//          ),
//          SizedBox(
//            height: 5,
//          ),
//          Flexible(
//            fit: FlexFit.tight,
//            child: AutoSizeText(
//              list[index]['recipe_name'],
//              style: GoogleFonts.lato(fontSize: 15),
//              softWrap: true,
//              overflow: TextOverflow.fade,
//              maxLines: 2,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
}
