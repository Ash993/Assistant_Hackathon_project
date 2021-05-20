import 'package:flutter/material.dart';
// import 'package:gorgeouslogin_app/home/home.dart';
import 'signin_page.dart';
import 'signup_page.dart';
import 'package:helpingwidget/shared/theme.dart';
import 'package:helpingwidget/utils/bubble_indicator_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;
  final _formkey =GlobalKey<FormState>();
  String error ='';
  bool loading =false;
  String email ='';
  String password='';

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    CustomTheme.loginGradientStart,
                    CustomTheme.loginGradientEnd
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: Image(
                      height:
                      MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
                      fit: BoxFit.fill,
                      image: const AssetImage('assets/images/login_logo.png')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (int i) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: const SignIn(),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: const SignUp(),
                      ),
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

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: ()async{
                  _pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    // dynamic result = await _auth.signInWithEmailAndPassword(email,password);
                    //
                    // if(result ==null){
                    //   setState(() {
                    //     error='could not sign in with those credentials';
                    //     loading=false;
                    //   });
                    // }

                  }

                },
                child: Text(
                  'Existing',
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: ()async{
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                  if(_formkey.currentState.validate())
                  {
                    setState(() {
                      loading=true;

                    });

                    // dynamic result =await _auth.registerWithEmailAndPassword(email,password);
                    // if(result== null){
                    //   setState(() {
                    //     error='please supply a valid email';
                    //     loading=false;
                    //
                    //   });
                    //
                    // }
                  }

                },
                child: Text(
                  'New',
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// int _onSignInButtonPress() {
//
//   return Home();
// }
//
// void _onSignUpButtonPress() {
//   _pageController?.animateToPage(1,
//       duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
// }
}