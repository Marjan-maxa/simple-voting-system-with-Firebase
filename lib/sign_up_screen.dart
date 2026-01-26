import 'package:flutter/material.dart';
import 'package:project_firebase/service/auth_service.dart';
import 'package:project_firebase/sign_up_screen.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwardController=TextEditingController();
  final auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text('Login Page',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80,),
              Text('Create Account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              const SizedBox(height: 25,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.deepOrange,),
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.deepOrange
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.deepOrange
                        )
                    )
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: passwardController,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password_sharp,color: Colors.deepOrange,),
                    hintText: 'Password',
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.deepOrange
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.deepOrange
                        )
                    )
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white
                    ),
                    onPressed: () async {
                     await auth.signUp(emailController.text, passwardController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created Successfully')));
                      emailController.clear();
                      passwardController.clear();
                      Navigator.pop(context);
                    }, child: Text('Sign Up')
                ),

              ),



            ],
          ),
        ),
      ),

    );
  }
}
