import 'package:flutter/material.dart';
import 'register.dart';
import 'scan_to_register.dart';

// Stateful widget for the Pmenu screen.
class Pmenu extends StatefulWidget { 
  const Pmenu({Key? key}) : super(key: key); 
  @override 
  State<Pmenu> createState() => _PmenuState(); 
} 

// State class for the Pmenu widget.
class _PmenuState extends State<Pmenu> { 
  Map userData = {}; 
  // Key to manage the form state.
  final _formkey = GlobalKey<FormState>(); 

  final Uri registerApi = Uri.parse('http://10.0.2.2:5000/RegisterRegistrar');
    
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Presiding Officer Menu'), 
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
                    height: 124,
                    width: 170,
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
                        padding: const EdgeInsets.all(28.0), 
                        child: SizedBox( 
                          width: MediaQuery.of(context).size.width, 
                          height: 45,
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
                              'Initialise Election', 
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
                          height: 45,
                          child: ElevatedButton( 
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScanRegister(apiEndpoint: registerApi),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Register Registrar', 
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
                          height: 45,
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
                              'Reset Registrar PW', 
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
                          height: 45,
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
                              'Start/Pause Counting', 
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
                          height: 45,
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
                              'Tally Votes', 
                              style: TextStyle( 
                                color: Colors.white, fontSize: 22), 
                            )
                          ), 
                        ), 
                      ), 
                       
                    ]), 
                )), 
              ), 
            ]), 
        ), 
      );
       
  
  } 
}