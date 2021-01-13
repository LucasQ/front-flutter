import 'package:flutter/material.dart';
import 'package:flutterApp/components/customAlert.dart';
import 'package:flutterApp/repository/authRepository.dart';

class LoginOptions extends StatefulWidget {
  LoginOptions({Key key, this.getNewsList, this.contextCard}) : super(key: key);

  final getNewsList;
  final contextCard;

  @override
  Options createState() => Options();
}

class Options extends State<LoginOptions> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.0, bottom: 20),
            width: 130,
            height: 130,
            child: Image.asset('assets/images/calendar.png'),
          ),
          Container(
              margin: EdgeInsets.only(left: 50.0, right: 50, bottom: 25),
              child: Text(
                'Faça login e acompanhe as últimas informações sobre os eventos',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              )),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.thumb_up, size: 20),
                          Text(
                            '  Entrar com o Facebook',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      color: Colors.blue[900],
                      padding: EdgeInsets.all(10),
                      onPressed: () async {
                        var result = await AuthRepository.signUpWithFacebook(
                            widget.getNewsList);
                        if (result != null) {
                          alert(widget.contextCard,
                              'Login efetuado com sucesso!!');
                        } else {
                          alert(context, 'Falha ao fazer o login');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.mail_outline, size: 20),
                          Text(
                            '  Entrar com o Google',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      textColor: Colors.black,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      onPressed: () async {
                        var result = await AuthRepository.googleSignUp(
                            widget.getNewsList);
                        if (result != null) {
                          alert(widget.contextCard,
                              'Login efetuado com sucesso!!');
                        } else {
                          alert(context, 'Falha ao fazer o login');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
