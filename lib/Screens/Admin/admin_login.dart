import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helpingwidget/Screens/Admin/admin_home_page.dart';
import 'package:helpingwidget/Screens/Admin/announcing_page.dart';

import 'package:helpingwidget/shared/theme.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
                    // child: _buildMenuBar(context),
                  ),
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
                                      hintText: 'New Password',
                                      hintStyle: const TextStyle(
                                          fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                                      suffixIcon: GestureDetector(
                                        // onTap: _toggleLogin,
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
                              return Navigator.push(context,MaterialPageRoute(builder: (context) => Announcing()),);


                            }
                        ),
                      )
                    ],
                  ),

                  // Expanded(
                  //   flex: 2,
                  //   child: PageView(
                  //     controller: _pageController,
                  //     physics: const ClampingScrollPhysics(),
                  //
                  //     children: <Widget>[
                  //       ConstrainedBox(
                  //         constraints: const BoxConstraints.expand(),
                  //         child: const SignIn(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
