import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/models/cuisine.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  final List<Recipe> recentRecipesWithLimit;
  final List<Recipe> recentRecipes;
  final List<Category> categories;
  final List<Cuisine> cuisine;
  final List<Recipe> mostCollected;
  final List<Recipe> allRecipes;

  LoginScreen(
      {this.allRecipes,
      this.recentRecipesWithLimit,
      this.recentRecipes,
      this.categories,
      this.cuisine,
      this.mostCollected});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
/* final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FacebookLogin facebookLogin = new FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _loginEmailController;
  TextEditingController _loginPasswordController;
  TextEditingController _loginResetPassEmailController;

  List<Recipe> recentRecipesWithLimit;
  List<Recipe> recentRecipes;
  List<Category> categories;
  List<Cuisine> cuisine;
  List<Recipe> mostCollected;
  List<Recipe> allRecipes;

  bool isRetrieving = true;

  void initState() {
    super.initState();
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();
    _loginResetPassEmailController = TextEditingController();
  }

  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  Future _retrieveData() async {
    // Get all categories
    await HttpService.getCategories().then((c) {
      setState(() {
        categories = c;
        print('Retrieved All Categories');
      });
    });

    // Get all cuisine
    await HttpService.getCuisine().then((c) {
      setState(() {
        cuisine = c;
        print('Retrieved All Cuisine');
      });
    });

    // Get all recipes
    await HttpService.getAllRecipes().then((r) {
      setState(() {
        allRecipes = r;
        print('Retrieved All Recipes');
      });
    });

    // Get most collected recipes
    await HttpService.getMostCollectedRecipes().then((r) {
      setState(() {
        mostCollected = r;
        print('Retrieved Most Collected Recipes');
      });
    });

    // Get recent recipes with a limit
    await HttpService.getRecentRecipesWithLimit().then((r) {
      setState(() {
        recentRecipesWithLimit = r;
        print('Retrieved Recent Recipes With Limit');
      });
    });

    // Get all recent recipes
    await HttpService.getRecentRecipes().then((r) {
      setState(() {
        recentRecipes = r;
        print('Retrieved All Recent Recipes');
        isRetrieving = false;
      });
    });

    loadingDialog(context).hide();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          height: queryData.size.height,
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(children: [
                  Image.asset(
                    'assets/images/logo.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ]),
                width: double.infinity,
                height: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    queryData.size.width / 7, 0, queryData.size.width / 7, 0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      customTextField(
                          context,
                          'Email',
                          Icon(Icons.mail, color: FsColor.primaryrecipe),
                          false,
                          _loginEmailController),
                      SizedBox(
                        height: 5,
                      ),
                      customTextField(
                          context,
                          'Password',
                          Icon(Icons.lock, color: FsColor.primaryrecipe),
                          true,
                          _loginPasswordController),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        elevation: 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: FsColor.primaryrecipe,
                        textColor: Colors.white,
                        child: Text(
                          'Sign In'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          await loadingDialog(context).show();
                          if (_loginEmailController.value.text.isNotEmpty &&
                              _loginPasswordController.value.text.isNotEmpty) {
                            if (EmailValidator.validate(
                                _loginEmailController.value.text.trim())) {
                              await HttpService.loginUser(
                                      context,
                                      _loginEmailController.value.text.trim(),
                                      _loginPasswordController.value.text
                                          .trim())
                                  .then((value) async {
                                if (value.id != null) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('id', value.id);
                                  await prefs.setString('email', value.email);
                                  await prefs.setString('fname', value.fname);
                                  await prefs.setString('lname', value.lname);
                                  if (allRecipes != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => TabsScreen(
                                            loginContext: context,
                                            allRecipes: widget.allRecipes,
                                            mostCollected: widget.mostCollected,
                                            recentRecipes: widget.recentRecipes,
                                            recentRecipesWithLimit:
                                                widget.recentRecipesWithLimit,
                                            categories: widget.categories,
                                            cuisine: widget.cuisine),
                                      ),
                                    );
                                  } else {
                                    await _retrieveData();
                                    (!isRetrieving)
                                        ? Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => TabsScreen(
                                                  loginContext: context,
                                                  allRecipes: allRecipes,
                                                  mostCollected: mostCollected,
                                                  recentRecipes: recentRecipes,
                                                  recentRecipesWithLimit:
                                                      recentRecipesWithLimit,
                                                  categories: categories,
                                                  cuisine: cuisine),
                                            ),
                                          )
                                        : CircularProgressIndicator();
                                  }
                                } else {
                                  loadingDialog(context).hide();
                                  Fluttertoast.showToast(
                                      msg: 'Wrong Email or Password!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1);
                                }
                              });
                            } else {
                              loadingDialog(context).hide();
                              Fluttertoast.showToast(
                                  msg: 'Invalid Email!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1);
                            }
                          } else {
                            loadingDialog(context).hide();
                            Fluttertoast.showToast(
                                msg: 'Please provide Email and Password!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1);
                          }
//                          loadingDialog(context).hide();
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                  contentPadding: EdgeInsets.only(bottom: 20),
                                  title: Text(
                                    'RESET PASSWORD',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 0),
                                        child: Text(
                                          'If you have forgotten your password, please enter your email and we will send you a verification code.',
                                          style: TextStyle(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: customTextField(
                                            context,
                                            'Email',
                                            Icon(Icons.mail,
                                                color: FsColor.primaryrecipe),
                                            false,
                                            _loginResetPassEmailController),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () async {
                                          await HttpService.resetPassword(
                                                  _loginResetPassEmailController
                                                      .value.text)
                                              .then((value) {
                                            Fluttertoast.showToast(
                                                msg: '$value');
                                            if (value ==
                                                'Please check your email!')
                                              Navigator.pop(context);
                                          });
                                        },
                                        color: FsColor.primaryrecipe,
                                        child: Text(
                                          'RESET',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ))),
                          child: AutoSizeText(
                            'Forgot Password?',
                            minFontSize: 13,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen())),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'Don\'t have an account? ',
                              minFontSize: 14,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                            AutoSizeText(
                              'Sign up now',
                              minFontSize: 14,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          divider(),
                          Text(
                            'Or',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          divider(),
                        ],
                      ),
                      loginButton(
                          context,
                          'Sign in with google',
                          Image.asset(
                            'assets/images/ic_google.png',
                            width: 25,
                          ),
                          Color(0xffdb4a39),
                          signInUsingGoogle),
                      SizedBox(
                        height: 15,
                      ),
                      loginButton(
                          context,
                          'Sign in with facebook',
                          Image.asset(
                            'assets/images/ic_facebook.png',
                            width: 22,
                          ),
                          Color(0xff3b5998),
                          signInUsingFacebook),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> retrieveDataAndLogin() async {
    await _retrieveData();

    if (recentRecipesWithLimit != null &&
        recentRecipes != null &&
        categories != null &&
        cuisine != null &&
        allRecipes != null &&
        mostCollected != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TabsScreen(
              loginContext: context,
              allRecipes: allRecipes,
              mostCollected: mostCollected,
              recentRecipes: recentRecipes,
              recentRecipesWithLimit: recentRecipesWithLimit,
              categories: categories,
              cuisine: cuisine),
        ),
      );
    }
  }

  void signInUsingGoogle() async {
    loadingDialog(context).show();
    FirebaseUser user;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    user = (await _auth.signInWithCredential(credential)).user;

    if (user != null) {
      _auth.currentUser().then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', value.uid);
        await prefs.setString('email', value.email);
        List name = value.displayName.split(" ");

        await HttpService.registerUser(
            value.uid, name[0], name[1], value.email, '', '', value.photoUrl);
      });
      retrieveDataAndLogin();
    }
  }

  void signInUsingFacebook() async {
    loadingDialog(context).show();
    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        facebookLogin.currentAccessToken.then((value) async {
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${value.token}');
          final profile = await json.decode(graphResponse.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('uid', profile['id']);
          await prefs.setString('email', profile['email']);

          await HttpService.registerUser(
              profile['id'],
              profile['first_name'],
              profile['last_name'],
              profile['email'],
              '',
              '',
              profile['picture']['data']['url']);
        });
        await _retrieveData();

        (recentRecipesWithLimit != null &&
                recentRecipes != null &&
                categories != null &&
                cuisine != null &&
                allRecipes != null &&
                mostCollected != null)
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => TabsScreen(
                      loginContext: context,
                      allRecipes: allRecipes,
                      mostCollected: mostCollected,
                      recentRecipes: recentRecipes,
                      recentRecipesWithLimit: recentRecipesWithLimit,
                      categories: categories,
                      cuisine: cuisine),
                ),
              )
            : CircularProgressIndicator();
        //retrieveDataAndLogin();
        break;
      case FacebookLoginStatus.cancelledByUser:
        loadingDialog(context).hide();
        break;
        break;
      case FacebookLoginStatus.error:
        loadingDialog(context).hide();
        break;
    }
  }

  Widget loginButton(BuildContext context, String text, Image image,
      Color color, Function function) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: function,
      padding: EdgeInsets.all(6),
      color: color,
      elevation: 4,
      textColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: image,
            maxRadius: 15,
            backgroundColor: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text(text.toUpperCase(), style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget divider() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          thickness: 1,
          color: Colors.black,
          height: 36,
        ),
      ),
    );
  }*/
}
