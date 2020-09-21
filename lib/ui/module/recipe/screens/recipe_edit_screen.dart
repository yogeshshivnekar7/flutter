import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/models/cuisine.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/flutter_multiselect.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/progress_dialog.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/single_select_chip.dart';

class EditRecipeScreen extends StatefulWidget {
  final String id,
      name,
      image,
      duration,
      serving,
      difficulty,
      cuisine,
      categories,
      ingredients,
      steps,
      userid,
      fname,
      lname,
      userimage,
      date;

  final Function getRecipes;

  EditRecipeScreen(
      {this.id,
      this.name,
      this.image,
      this.duration,
      this.serving,
      this.difficulty,
      this.cuisine,
      this.categories,
      this.ingredients,
      this.steps,
      this.userid,
      this.fname,
      this.lname,
      this.userimage,
      this.date,
      this.getRecipes});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
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

  // Recipe images path in the server
  String _path = HttpService.RECIPE_IMAGES_PATH;

  // Initializing the image picker
  final picker = ImagePicker();

  // Initializing variables and files
  String cuisine;
  String _selectedCuisine;
  String _selectedDifficulty;
  String _base64Image;
  File _tempImage;
  File _localImage;

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

    // Assigning values from the server
    _recipeNameController.text = widget.name;
    _recipeServingController.text = widget.serving;
    _recipeDurationController.text = widget.duration;
    _recipeDifficultyController.text = widget.difficulty;
    _recipeIngredientsController.text = widget.ingredients;
    _recipeStepsController.text = widget.steps;
    _recipeCategoryController.text = widget.categories;
    _recipeCuisineController.text = widget.cuisine;
    _selectedCuisine = widget.cuisine;
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

  Future chooseImage() async {
    var imageFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 500, maxHeight: 500);
    final bytes = await imageFile.readAsBytes();
    print("Picture original size: ${bytes.length}");
    var decodedImage =
        await decodeImageFromList(File(imageFile.path).readAsBytesSync());
    print("image width :${decodedImage.width}");
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Math.Random().nextInt(100000);
    Img.Image image = Img.decodeImage(File(imageFile.path).readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 700, height: 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 60));
    var decodedImage1 =
    await decodeImageFromList(File(compressImg.path).readAsBytesSync());
    print("image width compressImg:${decodedImage1.width}");
    final bytes1 = await compressImg.readAsBytes();
    print("Picture original re-size: ${bytes1.length}");

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
          'UPDATE RECIPE',
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
                          ? (widget.image != null)
                              ? CachedNetworkImage(
                                  imageUrl: '$_path${widget.image}',
                                  placeholder: (context, url) => ShimmerWidget(
                                      width: 125, height: 125, circular: false),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover)
                              : Center(
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
                      customTextField(
                          'Recipe Name',
                          _recipeNameController,
                          TextInputType.text,
                          _BOOLrecipeNameController,
                          "please enter recipe name "),
                      customTextField(
                          'Serving',
                          _recipeServingController,
                          TextInputType.number,
                          _BOOLrecipeServingController,
                          "please enter serving "),
                      customTextField(
                          'Duration(min)',
                          _recipeDurationController,
                          TextInputType.number,
                          _BOOLrecipeDurationController,
                          "please enter duration",
                          a: [
                            new WhitelistingTextInputFormatter(RegExp("[0-9]")),
                          ]),
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
                            errorText: _BOOLrecipeDifficultyController
                                ? "please select difficulty".toLowerCase()
                                : null,
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
                            errorText: _BOOLrecipeCategoryController
                                ? "please select categories".toLowerCase()
                                : null,
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
                            errorText: _BOOLrecipeCuisineController
                                ? 'please select cuisine'.toLowerCase()
                                : null,
                            labelText: 'Cuisine',
                            labelStyle:
                            TextStyle(fontSize: 13, fontFamily: 'Raleway')),
                      ),
                      customMultiLinesTextField(
                          'Ingredients',
                          _recipeIngredientsController,
                          _previewIngredientsList,
                          _BOOLrecipeIngredientsController,
                          "please enter ingredents "),
                      customMultiLinesTextField(
                          'Steps',
                          _recipeStepsController,
                          _previewStepsList,
                          _BOOLrecipeStepsController,
                          "please enter steps"),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0)),
                        color: FsColor.primaryrecipe,
                        textColor: Colors.white,
                        child: Text(
                          'Update Recipe',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        onPressed: () async {
                          /*if (_recipeNameController.value.text != null &&
                              _recipeServingController.value.text != null &&
                              _recipeDurationController.value.text != null &&
                              _recipeIngredientsController != null &&
                              _recipeStepsController != null) {*/
                          if (isValid()) {
                            loadingDialog(context).show();

                            String fileName;
                            if (null == _tempImage) {
                              _base64Image = '';
                              fileName = widget.image;
                            } else {
                              fileName = _tempImage.path.split('/').last;
                            }

                            if (_selectedCuisine == "none") {
                              setState(() {
                                cuisine = '';
                              });
                            } else {
                              setState(() {
                                cuisine =
                                    (_cuisineNames.indexOf(_selectedCuisine))
                                        .toString();
                                cuisine =
                                    _cuisine[int.parse(cuisine)].id.toString();
                              });
                            }
                            print(widget.id);
                            await HttpService.updateUserRecipe(
                              widget.id,
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
                            await widget.getRecipes();
                            loadingDialog(context).hide();
                            Toasly.success(
                                context, 'Recipe Updated Successfully!');
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 300,
                      )
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

  bool _BOOLrecipeNameController = false;
  bool _BOOLrecipeServingController = false;
  bool _BOOLrecipeDurationController = false;
  bool _BOOLrecipeDifficultyController = false;
  bool _BOOLrecipeCategoryController = false;
  bool _BOOLrecipeIngredientsController = false;
  bool _BOOLrecipeStepsController = false;
  bool _BOOLrecipeCuisineController = false;

  bool isValid() {
    bool isValid = true;
    /* if ((_base64Image == null)) {
      isValid = false;
      Fluttertoast.showToast(msg: 'Please provide an image');
    } else {}*/
    if (_recipeNameController.value.text
        .trim()
        .isEmpty) {
      setState(() {
        _BOOLrecipeNameController = true;
      });
      isValid = false;
    } else {
      setState(() {
        _BOOLrecipeNameController = false;
      });
    }
    if (_recipeServingController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeServingController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeServingController = false;
      });
    }

    if (_recipeDurationController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeDurationController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeDurationController = false;
      });
    }
    if (_recipeDifficultyController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeDifficultyController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeDifficultyController = false;
      });
    }

    if (_recipeCategoryController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeCategoryController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeCategoryController = false;
      });
    }

    if (_recipeCuisineController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeCuisineController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeCuisineController = false;
      });
    }

    if (_recipeIngredientsController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeIngredientsController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeIngredientsController = false;
      });
    }

    if (_recipeStepsController.value.text
        .trim()
        .isEmpty) {
      isValid = false;
      setState(() {
        _BOOLrecipeStepsController = true;
      });
    } else {
      setState(() {
        _BOOLrecipeStepsController = false;
      });
    }

    return isValid;
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

  /*Widget customTextField(String label, TextEditingController controller,
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
  }*/
  customTextField(String label, TextEditingController controller,
      TextInputType textInputType, bool isValid, String error,
      {List<TextInputFormatter> a}) {
    return TextField(
      inputFormatters: a,
      onSubmitted: (v) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      controller: controller,
      keyboardType: textInputType,
      style:
      TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 13, fontFamily: 'Raleway'),
        errorText: isValid ? error.toLowerCase() : null,
      ),
    );
  }

  Widget customMultiLinesTextField(String label,
      TextEditingController controller,
      List<String> list,
      bool isValid,
      String error) {
    return TextField(
      controller: controller,
      maxLines: 5,
      style:
      TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
      decoration: InputDecoration(
        errorText: isValid ? error.toLowerCase() : null,
        suffixIcon: IconButton(
          onPressed: () async {
            if (label == 'Ingredients')
              await _previewIngredients(controller);
            else if (label == 'Steps') await _previewSteps(controller);

            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      contentPadding: EdgeInsets.only(bottom: 20),
                      title: Text(
                        '$label Preview',
                        style: TextStyle(fontSize: 16),
                      ),
                      content: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemExtent: 40,
                        itemBuilder: (ctx, index) =>
                        (label == 'Ingredients')
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

  /* Widget customMultiLinesTextField(
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
  }*/

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
