import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'register.dart';
import 'reset_password.dart';
import 'zzzdemo_menu.dart';


// Stateful widget for the Login screen.
class Login extends StatefulWidget { 
  const Login({Key? key}) : super(key: key); 
  @override 
  State<Login> createState() => _LoginState(); 
} 

// State class for the Login widget.
class _LoginState extends State<Login> { 
  // Map to store user data (if needed in the future).
  Map userData = {}; 
  // Key to manage the form state.
  final _formkey = GlobalKey<FormState>(); 
  bool _passwordVisible = false;

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Login'), 
        backgroundColor: Color.fromARGB(255, 0, 77, 68), 
        foregroundColor: Colors.white, 
        centerTitle: true, 
      ), 
      body: SingleChildScrollView( 
        child: Column( 
          children: <Widget>[ 
            Padding( 
              padding: const EdgeInsets.only(top: 30.0), 
              child: Center( 
                child: Container( 
                  width: 124, 
                  height: 170, 
                  child: Image.asset(
                    'assets/harp.png', 
                    height: 30,
                    width: 20,
                  ), 
                ), 
              ), 
            ), 
            Padding( //user input area
              padding: EdgeInsets.symmetric(horizontal: 15), 
              child: Padding( 
                padding: const EdgeInsets.all(12.0), 
                child: Form( 
                  key: _formkey, 
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: <Widget>[ 
                      Padding( 
                        padding: const EdgeInsets.all(12.0), 
                        child: TextFormField( 
                          validator: MultiValidator([ 
                            RequiredValidator( 
                              errorText: 'Enter email address'), 
                            EmailValidator( 
                              errorText: 'Please correct email filled'), 
                          ]).call,
                          decoration: InputDecoration( 
                            // Placeholder text.
                            hintText: 'Email', 
                            // Label for the field.
                            labelText: 'Email', 
                            prefixIcon: Icon(
                              // Email icon.
                              Icons.email, 
                            ), 
                            // Error message styling.
                            errorStyle: TextStyle(fontSize: 18.0), 
                            border: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.red), 
                              borderRadius: BorderRadius.all( 
                                // Rounded border.
                                Radius.circular(9.0)) 
                            )
                          )
                        )
                      ), 
                      // Password input field.
                      Padding( 
                        padding: const EdgeInsets.all(12.0), 
                        child: TextFormField( 
                          obscureText: _passwordVisible,
                          validator: MultiValidator([ 
                            RequiredValidator(
                              // Validation for required field.
                              errorText: 'Please enter Password'), 
                            MinLengthValidator(8,
                              // Minimum length validation.
                              errorText: 'Password must be at least 8 characters'), 
                            PatternValidator(r'(?=.*?[#!@$%^&*-])',
                              // Special character validation.
                              errorText: 'One special character minimum required') 
                          ]).call, 
                          decoration: InputDecoration( 
                            hintText: 'Password', 
                            labelText: 'Password', 
                            prefixIcon: Icon( 
                              Icons.key, 
                              color: Colors.green, 
                            ), 
                            suffixIcon: IconButton(
                              tooltip: _passwordVisible
                                  ? 'Hide password'
                                  : 'Show password',
                             icon: Icon(
                               _passwordVisible
                                   ? Icons.visibility_off
                                   : Icons.visibility,
                             ),
                             onPressed: () => setState(() {
                               _passwordVisible = !_passwordVisible;
                             }),
                           ),
                            errorStyle: TextStyle(fontSize: 18.0), 
                            border: OutlineInputBorder( 
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(9.0)) 
                            ), 
                          ), 
                        ), 
                      ), 
                      Container( 
                        margin: EdgeInsets.fromLTRB(200, 0, 0, 0), 
                        child: InkWell( 
                          child: Text('Forgot Password'), 
                          onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResetPage(),
                                  ),
                                );
                              },
                        ),
                      ), 
                      Padding( 
                        padding: const EdgeInsets.all(28.0), 
                        child: SizedBox( 
                          width: MediaQuery.of(context).size.width, 
                          height: 50, 
                          child: ElevatedButton( 
                            onPressed: () { 
                              if (_formkey.currentState!.validate()) { 
                                //if from validated do stuff
                                print('form submitted'); 
                              } 
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Login', 
                              style: TextStyle( 
                                color: Colors.white, fontSize: 22), 
                            )
                          ), 
                        ), 
                      ), 
                      Padding( 
                        padding: const EdgeInsets.all(28.0), 
                        child: SizedBox( 
                          width: MediaQuery.of(context).size.width, 
                          height: 50, 
                          child: ElevatedButton( 
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Register', 
                              style: TextStyle( 
                                color: Colors.white, fontSize: 22), 
                            )
                          ), 
                        ), 
                      ), 
                      
                      //Demo Menu option
                      Center( 
                        child: Container( 
                          padding: EdgeInsets.only(top: 50), 
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DemoMenu(),
                                ),
                              );
                            },
                            child: Text( 
                              'Demo Menu', 
                              style: TextStyle( 
                                fontSize: 20, 
                                fontWeight: FontWeight.w700, 
                                color: Colors.lightBlue, 
                              ), 
                            ),
                          ), 
                        ), 
                      ) 

                    ]), 
                )), 
              ), 
            ]), 
        
        ), 
      );
       
  
  } 
}