import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/models/cuisine.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/flutter_multiselect.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/progress_dialog.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/single_select_chip.dart';

class ProfileAddRecipeScreen extends StatefulWidget {
  @override
  _ProfileAddRecipeScreenState createState() => _ProfileAddRecipeScreenState();
}

class _ProfileAddRecipeScreenState extends State<ProfileAddRecipeScreen> {
  // Initializing input controllers
  TextEditingController _recipeNameController;
  TextEditingController _recipeServingController;
  TextEditingController _recipeDurationController;
  TextEditingController _recipeDifficultyController;
  TextEditingController _recipeCategoryController;
  TextEditingController _recipeCuisineController;
  TextEditingController _recipeIngredientsController;
  TextEditingController _recipeStepsController;

  // Initializing data lists
  List<String> _difficulty = List<String>();
  List<Category> _categories = List<Category>();
  List<Cuisine> _cuisine = List<Cuisine>();
  List<String> _cuisineNames = List<String>();
  List<String> _categoryNames = List<String>();
  List<String> _selectedCategoriesList = List();
  List<String> _previewIngredientsList = List<String>();
  List<String> _previewStepsList = List<String>();

  // Initializing the image picker
  final picker = ImagePicker();

  // Initializing variables and files
  String cuisine;
  String _selectedCuisine;
  String _selectedDifficulty;
  String _base64Image;
  File _tempImage;
  File _localImage;
  String _userId;

  void initState() {
    super.initState();
    _recipeNameController = TextEditingController();
    _recipeServingController = TextEditingController();
    _recipeDurationController = TextEditingController();
    _recipeDifficultyController = TextEditingController();
    _recipeCategoryController = TextEditingController();
    _recipeCuisineController = TextEditingController();
    _recipeIngredientsController = TextEditingController();
    _recipeStepsController = TextEditingController();

    // Retrieve the list of available categories and cuisine.
    retrieveData();
  }

  void dispose() {
    _recipeNameController.dispose();
    _recipeServingController.dispose();
    _recipeDurationController.dispose();
    _recipeDifficultyController.dispose();
    _recipeCategoryController.dispose();
    _recipeCuisineController.dispose();
    _recipeIngredientsController.dispose();
    _recipeStepsController.dispose();
    super.dispose();
  }

  _clearAllFields() {
    _localImage = null;
    _base64Image = null;
    _recipeNameController.clear();
    _recipeServingController.clear();
    _recipeDurationController.clear();
    _recipeDifficultyController.clear();
    _recipeCategoryController.clear();
    _recipeCuisineController.clear();
    _recipeIngredientsController.clear();
    _recipeStepsController.clear();
  }

  Future chooseImage() async {
    var imageFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 500, maxHeight: 500);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(File(imageFile.path).readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 800);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 90));

    setState(() {
      _localImage = compressImg;
      _tempImage = _localImage;
      _base64Image = base64Encode(_localImage.readAsBytesSync());
    });
  }

  Future retrieveData() async {
    // Get all categories
    await HttpService.getCategories().then((c) {
      setState(() {
        _categories = c;
        for (int i = 0; i < _categories.length; i++) {
          _categoryNames.add(_categories[i].name);
        }
        print('Retrieved All Categories');
      });
    });

    // Get all cuisine
    await HttpService.getCuisine().then((c) {
      setState(() {
        _cuisine = c;
        for (int i = 0; i < _cuisine.length; i++) {
          _cuisineNames.add(_cuisine[i].name);
        }
        _cuisineNames.add('none');
        print('Retrieved All Cuisine');
      });
    });

    // Add options to the difficulty list
    setState(() {
      _difficulty.add('Easy');
      _difficulty.add('Medium');
      _difficulty.add('Hard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'ADD RECIPE',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomPadding: false,
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Column(
              children: [
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: chooseImage,
                    child: Container(
                      width: 125,
                      height: 125,
                      child: (_localImage == null)
                          ? Center(
                              child: Icon(Icons.add, size: 35),
                            )
                          : Image.file(_localImage, fit: BoxFit.cover),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.all(10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      customTextField('Recipe Name', _recipeNameController,
                          TextInputType.text),
                      customTextField('Serving', _recipeServingController,
                          TextInputType.number),
                      customTextField('Duration', _recipeDurationController,
                          TextInputType.number),
                      TextFormField(
                        readOnly: true,
                        showCursor: false,
                        controller: _recipeDifficultyController,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontSize: 17),
                        onTap: () {
                          showDifficultyPicker(_recipeDifficultyController);
                        },
                        decoration: InputDecoration(
                            labelText: 'Difficulty',
                            labelStyle:
                                TextStyle(fontSize: 13, fontFamily: 'Raleway')),
                      ),
                      TextFormField(
                        controller: _recipeCategoryController,
                        readOnly: true,
                        showCursor: false,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontSize: 17),
                        onTap: () {
                          _showCategoryDialog(
                              _categoryNames,
                              _selectedCategoriesList,
                              _recipeCategoryController);
                        },
                        decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle:
                                TextStyle(fontSize: 13, fontFamily: 'Raleway')),
                      ),
                      TextFormField(
                        readOnly: true,
                        showCursor: false,
                        controller: _recipeCuisineController,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontSize: 17),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _showCuisineDialog();
                        },
                        decoration: InputDecoration(
                            labelText: 'Cuisine',
                            labelStyle:
                                TextStyle(fontSize: 13, fontFamily: 'Raleway')),
                      ),
                      customMultiLinesTextField(
                          'Ingredients',
                          _recipeIngredientsController,
                          _previewIngredientsList),
                      customMultiLinesTextField(
                          'Steps', _recipeStepsController, _previewStepsList),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0)),
                        color: FsColor.primaryrecipe,
                        textColor: Colors.white,
                        child: Text(
                          'Add Recipe',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        onPressed: () async {
                          if (_recipeNameController.value.text != null &&
                              _recipeServingController.value.text != null &&
                              _recipeDurationController.value.text != null &&
                              _recipeIngredientsController != null &&
                              _recipeStepsController != null) {
                            if (_base64Image != null) {
                              loadingDialog(context).show();

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              if (prefs.getString('id') != null) {
                                setState(() {
                                  _userId = prefs.getString('id').toString();
                                });
                              } else {
                                setState(() {
                                  _userId = prefs.get('uid');
                                });
                              }

                              if (null == _tempImage) {
                                print('No Image Provided');
                                return;
                              }
                              String fileName = _tempImage.path.split('/').last;

                              print(_cuisineNames
                                  .indexOf(_selectedCuisine)
                                  .toString());
                              if (_selectedCuisine == "none") {
                                setState(() {
                                  cuisine = '';
                                });
                              } else {
                                setState(() {
                                  cuisine = _cuisineNames
                                      .indexOf(_selectedCuisine)
                                      .toString();
                                });
                              }
                              await HttpService.addRecipe(
                                _userId,
                                _recipeNameController.value.text,
                                _recipeServingController.value.text,
                                _recipeDurationController.value.text,
                                _recipeDifficultyController.value.text,
                                _recipeCategoryController.value.text,
                                cuisine,
                                _recipeIngredientsController.value.text,
                                _recipeStepsController.value.text,
                                _base64Image,
                                fileName,
                              );

                              _clearAllFields();

                              loadingDialog(context).hide();
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Please provide an image');
                            }
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showCategoryDialog(List<String> list, List<String> selectedItems,
      TextEditingController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Categories"),
            content: MultiSelectChip(
              list,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedItems = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.text = selectedItems.join(",");
                },
              )
            ],
          );
        });
  }

  _showCuisineDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select a Cuisine"),
            content: SingleSelectChip(
              _cuisineNames,
              onSelectionChanged: (selected) {
                setState(() {
                  _selectedCuisine = selected;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _recipeCuisineController.text = _selectedCuisine;
                },
              )
            ],
          );
        });
  }

  showDifficultyPicker(TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //Here we will build the content of the dialog
        return AlertDialog(
          title: Text("Select Difficulty"),
          content: SingleSelectChip(
            _difficulty,
            onSelectionChanged: (selected) {
              setState(() {
                _selectedDifficulty = selected;
              });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
                _recipeDifficultyController.text = _selectedDifficulty;
              },
            )
          ],
        );
      },
    );
  }

  Widget customTextField(String label, TextEditingController controller,
      TextInputType textInputType) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      style:
          TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 13, fontFamily: 'Raleway')),
    );
  }

  Widget customMultiLinesTextField(
      String label, TextEditingController controller, List<String> list) {
    return TextField(
      controller: controller,
      maxLines: 5,
      style:
          TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () async {
            if (label == 'Ingredients')
              await _previewIngredients(controller);
            else if (label == 'Steps') await _previewSteps(controller);

            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      contentPadding: EdgeInsets.only(bottom: 20),
                      title: Text(
                        '$label Preview',
                        style: TextStyle(fontSize: 16),
                      ),
                      content: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemExtent: 40,
                        itemBuilder: (ctx, index) => (label == 'Ingredients')
                            ? checkBoxListTile(context, index, list)
                            : stepsListTile(context, index, list),
                        itemCount: list.length,
                      ),
                    ));
          },
          icon: Icon(Icons.remove_red_eye),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: 13, fontFamily: 'Raleway'),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget checkBoxListTile(BuildContext context, int index, List items) {
    return CheckboxListTile(
      value: false,
      dense: true,
      onChanged: null,
      controlAffinity: ListTileControlAffinity.leading,
      title: AutoSizeText(
        items[index],
        style: GoogleFonts.lato(fontSize: 14.5, fontWeight: FontWeight.normal),
        maxLines: 2,
      ),
    );
  }

  Widget stepsListTile(BuildContext context, int index, List items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: <Widget>[
          AutoSizeText(
            '${index + 1}.',
            style: GoogleFonts.pacifico(),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: AutoSizeText(
              items[index],
              style: GoogleFonts.lato(
                  fontSize: 14.5, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  _previewIngredients(TextEditingController controller) {
    _previewIngredientsList.clear();
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(controller.value.text);
    for (var i = 0; i < lines.length; i++) {
      _previewIngredientsList.add(lines[i]);
    }
  }

  _previewSteps(TextEditingController controller) {
    _previewStepsList.clear();
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(controller.value.text);
    for (var i = 0; i < lines.length; i++) {
      _previewStepsList.add(lines[i]);
    }
  }
}
