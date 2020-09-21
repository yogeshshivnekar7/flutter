import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_widget/search_widget.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_recent_list_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/translation/app_localizations.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/home_recipe_item.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';
import 'package:carousel_slider/carousel_options.dart';

class HomeScreen extends StatefulWidget {
  final List<Recipe> mostCollectedRecipes;
  final List<Recipe> allRecipes;

  HomeScreen({this.mostCollectedRecipes, this.allRecipes});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _recentRecipesWithLimit;
  List<Recipe> _recentRecipes;
  String _path = HttpService.RECIPE_IMAGES_PATH;
  bool _isRetrieving = true;

  @override
  void initState() {
    super.initState();
    // Initializing firebase for admob
    // FirebaseAdMob.instance.initialize(appId: Constants.AppId);
    _retrieveData();
  }

  // Get recent recipes
  Future _retrieveData() async {
    // Get recent recipes with a limit
    await HttpService.getRecentRecipesWithLimit().then((r) {
      setState(() {
        _recentRecipesWithLimit = r;
        //   print('Retrieved Recent Recipes With Limit');
      });
    });

    // Get all recent recipes
    await HttpService.getRecentRecipes().then((r) {
      setState(() {
        _recentRecipes = r;
        //print('Retrieved All Recent Recipes');
      });
    });

    setState(() {
      _isRetrieving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          (widget.allRecipes != null)
              ? SearchWidget<Recipe>(
                  dataList: widget.allRecipes,
                  hideSearchBoxWhenItemSelected: false,
                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                  queryBuilder: (String query, List<Recipe> list) {
                    return list
                        .where((Recipe item) => item.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  },
                  popupListItemBuilder: (Recipe item) {
                    return popupListItemWidget(item);
                  },
                  selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                    return selectedItemWidget(selectedItem, deleteSelectedItem);
                  },
                  onItemSelected: (item) {
                    onItemSelected(item);
                  },
                  // widget customization
                  noItemsFoundWidget: noItemsFound(),
                  textFieldBuilder:
                      (TextEditingController controller, FocusNode focusNode) {
                    return textField(controller, focusNode);
                  },
                )
              : CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
            child: AutoSizeText(
              AppLocalizations.of(context).translate('most_collected'),
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          widget.mostCollectedRecipes == null
              ? Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      'No Recipes To Display',
                      style: GoogleFonts.pacifico(fontSize: 14),
                    ),
                  ),
                )
              : CarouselSlider.builder(
                  itemCount: widget.mostCollectedRecipes.length,
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  itemBuilder: (ctx, index) {
                    // print(widget.mostCollectedRecipes[index].name);
                    return Container(
                      child: buildCarouselItem(
                          context,
                          index,
                          widget.mostCollectedRecipes[index].name,
                          _path + widget.mostCollectedRecipes[index].image),
                    );
                  },
                ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
            child: Row(
              children: [
                AutoSizeText(
                  AppLocalizations.of(context).translate('recent'),
                  style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeRecentList(_recentRecipes),
                        ),
                      );
                    },
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('view_all'),
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          (!_isRetrieving)
              ? _recentRecipesWithLimit != null
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification:
                            (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
                            return Column(
                              children: <Widget>[
                                HomeRecipeItem(
                                  recipe: _recentRecipesWithLimit,
                                  index: i,
                                  path: HttpService.RECIPE_IMAGES_PATH,
                                ),
                                i == _recentRecipesWithLimit.length - 1
                                    ? SizedBox(
                                  height: 100,
                                )
                                    : Container(),
                              ],
                            );
                          },
                          itemCount: _recentRecipesWithLimit == null
                              ? 0
                              : _recentRecipesWithLimit.length,
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('no_recent_recipes'),
                          style: GoogleFonts.pacifico(fontSize: 15),
                        ),
                      ),
                    )
              : Container(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(
      BuildContext context, int index, String text, String image) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 3,
      child: Container(
        margin: EdgeInsets.all(0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(
                        id: widget.mostCollectedRecipes[index].id,
                        name: widget.mostCollectedRecipes[index].name,
                        image: widget.mostCollectedRecipes[index].image,
                        duration: widget.mostCollectedRecipes[index].duration,
                        serving: widget.mostCollectedRecipes[index].serving,
                        difficulty:
                            widget.mostCollectedRecipes[index].difficulty,
                        cuisine: widget.mostCollectedRecipes[index].cuisine,
                        categories:
                            widget.mostCollectedRecipes[index].categories,
                        ingredients:
                            widget.mostCollectedRecipes[index].ingredients,
                        steps: widget.mostCollectedRecipes[index].steps,
                        fName: widget.mostCollectedRecipes[index].fname,
                        lName: widget.mostCollectedRecipes[index].lname,
                        userImage: widget.mostCollectedRecipes[index].userimage,
                        date: widget.mostCollectedRecipes[index].date,
                        userId: widget.mostCollectedRecipes[index].userId,
                      ),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    placeholder: (context, url) => ShimmerWidget(
                      width: 1000,
                      height: 200,
                      circular: false,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget popupListItemWidget(Recipe recipe) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        recipe.name,
        style: GoogleFonts.pacifico(fontSize: 16),
      ),
    );
  }

  void onItemSelected(Recipe selectedItem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(
          id: selectedItem.id,
          name: selectedItem.name,
          image: selectedItem.image,
          duration: selectedItem.duration,
          serving: selectedItem.serving,
          difficulty: selectedItem.difficulty,
          cuisine: selectedItem.cuisine,
          categories: selectedItem.categories,
          ingredients: selectedItem.ingredients,
          steps: selectedItem.steps,
          fName: selectedItem.fname,
          lName: selectedItem.lname,
          userImage: selectedItem.userimage,
          date: selectedItem.date,
          userId: selectedItem.userId,
        ),
      ),
    );
  }

  Widget noItemsFound() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Recipes Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget textField(TextEditingController controller, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          border: InputBorder.none,
          hintText: AppLocalizations.of(context).translate('search_here'),
          hintStyle: GoogleFonts.pacifico(
              color: Colors.black54, fontWeight: FontWeight.w100),
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 10,
            bottom: 10,
          ),
        ),
      ),
    );
  }

  Widget selectedItemWidget(
      Recipe selectedItem, VoidCallback deleteSelectedItem) {
    return Container();
  }
}
