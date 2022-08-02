import 'package:flutter/material.dart';
import 'package:ordermanagement/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO SOMETHING',
              style: TextStyle(
                fontSize: 42,
              ),
            ),

            SizedBox(height: 32),

            SizedBox(
              height: 52,
              width: 100,
              child: ElevatedButton(onPressed: (){
                final _emailController = TextEditingController();
                final _passController = TextEditingController();
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: Text(
                    'Login to continue'
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email'
                        ),
                      ),
                      TextField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password'
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text('Cancel',style: TextStyle(color: Colors.red),)),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage()));
                    }, child: Text('Login')),
                  ],
                ));
              }, child: Text('Login')),
            )
          ],
        ),
      ),
    );
  }
}
