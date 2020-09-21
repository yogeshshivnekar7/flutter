import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/cookbook_recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

import '../database/cookbook_db_helper.dart';
import '../translation/app_localizations.dart';

var db = new CookBookDatabaseHelper();

Future<List> fetchRecipesFromDatabase() async {
  return db.getAllRecipes();
}

class CookbookScreen extends StatefulWidget {
  @override
  _CookbookScreenState createState() => _CookbookScreenState();
}

class _CookbookScreenState extends State<CookbookScreen> {
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    print(queryData.size.width);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Cookbook'.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FutureBuilder<List>(
          future: fetchRecipesFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length > 0
                  ? GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            queryData.size.width / queryData.size.height / 0.6,
                        crossAxisSpacing: queryData.size.width / 24,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        return cookbookRecipeItem(
                            context,
                            queryData,
                            snapshot.data,
                            index,
                            HttpService.RECIPE_IMAGES_PATH);
                      })
                  : Center(
                      child: Text(
                      AppLocalizations.of(context)
                          .translate('you_have_no_saved_recipes'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.pacifico(
                          fontSize: queryData.size.width / 20),
                    ));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void selectRecipe(BuildContext context, int index, List list) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => CookbookRecipeDetailsScreen(
          id: list[index]['recipe_id'].toString(),
          name: list[index]['recipe_name'],
          image: list[index]['recipe_image'],
          duration: list[index]['recipe_duration'],
          serving: list[index]['recipe_serving'],
          difficulty: list[index]['recipe_difficulty'],
          cuisine: list[index]['recipe_cuisine'],
          categories: list[index]['recipe_categories'],
          ingredients: list[index]['recipe_ingredients'],
          steps: list[index]['recipe_steps'],
          date: list[index]['date'],
          userId: list[index]['user_id'],
          userImage: list[index]['image'],
          lName: list[index]['lname'],
          fName: list[index]['fname'],
        ),
      ),
    )
        .then((result) {
      setState(() {
        fetchRecipesFromDatabase();
      });
    });
  }

  Widget cookbookRecipeItem(
      BuildContext context, var queryData, List list, int index, String path) {
    return InkWell(
      onTap: () => selectRecipe(context, index, list),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: '$path${list[index]['recipe_image']}',
              placeholder: (context, url) => ShimmerWidget(
                width: double.infinity,
                height: queryData.size.width / 3,
                circular: false,
              ),
              width: double.infinity,
              height: queryData.size.width / 3,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: AutoSizeText(
              list[index]['recipe_name'],
              style: GoogleFonts.lato(fontSize: 15),
              softWrap: true,
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
