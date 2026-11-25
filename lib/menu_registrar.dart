import 'package:flutter/material.dart';
import 'scan_to_register.dart';
import 'reset_password.dart';

// Stateful widget for the RMenu screen.
class RMenu extends StatefulWidget { 
  const RMenu({Key? key}) : super(key: key); 
  @override 
  State<RMenu> createState() => _RMenuState(); 
} 

// State class for the RMenu widget.
class _RMenuState extends State<RMenu> { 
  Map userData = {}; 
  // Key to manage the form state.
  final _formkey = GlobalKey<FormState>(); 
  final Uri registerApi = Uri(
    scheme:'http', 
    host: '10.0.2.2',
    path: '/RegisterCounter'
  );
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Registrar Menu'), 
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
            Padding( 
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
                                  builder: (context) => ScanRegister(apiEndpoint: registerApi),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Register Counter', 
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
                                  builder: (context) => const ResetPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Reset Counter PW', 
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