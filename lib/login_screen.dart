import 'package:flutter/material.dart';
import 'package:project_firebase/service/auth_service.dart';
import 'package:project_firebase/sign_up_screen.dart';
import 'package:project_firebase/task_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwardController=TextEditingController();
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                Text('Welcome to Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                    final usereVarified= await AuthService().login(emailController.text, passwardController.text);
                    if(usereVarified!.emailVerified){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successfully!')));

                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please verified your email..!')));

                    }

                      }, child: Text('Login')
                  ),

                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){}, child: Text('Forgot Password?')),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                }, child: Text('Create Account')),
              ],
            ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                     final user=await AuthService().signInWithGoogle();
                     if(user!=null){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
                     }else{
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Worng!')));
                     }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            'https://1000logos.net/wp-content/uploads/2016/11/New-Google-Logo.jpg',
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}
