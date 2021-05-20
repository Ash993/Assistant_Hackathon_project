import 'package:flutter/material.dart';
import 'package:helpingwidget/Screens/Admin/admin_login.dart';
import 'package:helpingwidget/Screens/User/login_page.dart';
import 'background.dart';
import 'package:helpingwidget/components/rounded_button.dart';
import 'package:helpingwidget/shared/const.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Application Assistant",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.deepPurple),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "ADMIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AdminLogin();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "USER",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}