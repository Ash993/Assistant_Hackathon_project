import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helpingwidget/Screens/User/user_home_page.dart';
// import 'package:gorgeouslogin_app/home/home.dart';
// import 'package:gorgeouslogin_app/pages/resetpassword.dart';
import 'package:helpingwidget/shared/loading.dart';
import 'package:helpingwidget/shared/theme.dart';
import 'package:helpingwidget/widgets/snackbar.dart';



class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey =GlobalKey<FormState>();
  String email ='';
  String password='';
  String error ='';
  bool loading =false;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 300.0,
                    height: 190.0,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                            child: TextFormField(

                              focusNode: focusNodeEmail,
                              controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                    fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                              ),
                              validator: (val)=>(val.isEmpty || !val.contains('@'))? 'Enter an email': null,
                              onChanged: (val) {
                                setState(() {
                                  email=val;
                                });

                              },

                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              focusNode: focusNodePassword,
                              controller: loginPasswordController,
                              obscureText: _obscureTextPassword,
                              style: const TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: const Icon(
                                  FontAwesomeIcons.lock,
                                  size: 22.0,
                                  color: Colors.black,
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Icon(
                                    _obscureTextPassword
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (val) =>val.length<6 ?'Enter a password 6+ chars long': null,

                              onChanged: (val) {
                                setState(() {
                                  password=val;
                                });
                              },
                              textInputAction: TextInputAction.go,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 170.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomTheme.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: CustomTheme.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: LinearGradient(
                        colors: <Color>[
                          CustomTheme.loginGradientEnd,
                          CustomTheme.loginGradientStart
                        ],
                        begin: FractionalOffset(0.2, 0.2),
                        end: FractionalOffset(1.0, 1.0),
                        stops: <double>[0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: CustomTheme.loginGradientEnd,
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'WorkSansBold'),
                        ),
                      ),
                      onPressed: () async{
                        return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserHomePage()));
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
                      }
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                onPressed: () {
                  // return Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ResetPassword()));

                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansMedium'),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[
                            Colors.white10,
                            Colors.white,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 1.0),
                          stops: <double>[0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      'Or',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansMedium'),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[
                            Colors.white,
                            Colors.white10,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 1.0),
                          stops: <double>[0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 40.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.facebookF,
                        color: Color(0xFF0084ff),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: (){
                      // return Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Start()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFF0084ff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.65),
            Text(
              error,
              style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.height * 0.65),
            ),

          ],
        ),
      ),
    );
  }

  // void _toggleSignInButton() {
  //
  // }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}