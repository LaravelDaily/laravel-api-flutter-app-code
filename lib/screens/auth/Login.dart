import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 20), // Acts as a spacer
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 20), // Acts as a spacer
                        ElevatedButton(
                          onPressed: () {
                            print('Login button pressed');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 40),
                          ),
                          child: Text('Login'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20), // Different way to add padding
                          child: InkWell(
                            child: Text('Register new User'),
                            onTap: () => Navigator.pushNamed(context, '/register')
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
