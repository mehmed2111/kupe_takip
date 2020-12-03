import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kupe/constants.dart';
import 'package:kupe/functions/beni_hatirla.dart';
import 'package:kupe/screens/home_page.dart';
import 'package:kupe/screens/sifremi_unuttum.dart';
import 'package:kupe/widgets/alert_dialog.dart';
import 'package:kupe/widgets/rounded_button.dart';
import 'package:kupe/widgets/sifremi_unuttum_butonu.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  bool showSpinner = false;
  String username;
  String password;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(begin: Color(0xFF5CB3AB), end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo_transparent.png'),
                  ),
                ),
              ),
              TypewriterAnimatedTextKit(
                text: ['Küpe Takip'],
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1d2136),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                cursorColor: Color(0xFF5CB3AB),
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Kullanıcı adı',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                cursorColor: Color(0xFF5CB3AB),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Şifre',
                ),
              ),
              SizedBox(height: 8.0),
              BeniHatirla(),
              RoundedButton(
                colour: Color(0xFF5CB3AB),
                buttonTitle: 'GİRİŞ YAP',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    /*
                      final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                      if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      }*/
                    if (username != null && password != null) {
                      Navigator.pushNamed(context, HomePage.id);
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialogWidget(
                              dialogTitle: 'Hata!',
                              dialogContent:
                                  'Kullanıcı adı ve şifre boş bırakılamaz!',
                              kapatBtnTitle: 'Kapat',
                              onPressed: () {
                                Navigator.pop(context);
                              }));
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(height: 24),
              SifremiUnuttumButonu(onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return SifremiUnuttum();
                    }));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
