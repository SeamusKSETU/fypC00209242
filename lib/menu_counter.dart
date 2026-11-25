import 'package:flutter/material.dart';
import 'register.dart';

// Stateful widget for the CMenu screen.
class CMenu extends StatefulWidget { 
  const CMenu({Key? key}) : super(key: key); 
  @override 
  State<CMenu> createState() => _CMenuState(); 
} 

// State class for the CMenu widget.
class _CMenuState extends State<CMenu> { 
  Map userData = {}; 
  // Key to manage the form state.
  final _formkey = GlobalKey<FormState>(); 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Vote Counter Menu'), 
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
                                  builder: (context) => const RegisterPage(), //TODO
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Scan Votes', 
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