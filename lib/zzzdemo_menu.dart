import 'package:flutter/material.dart';
import 'menu_pofficer.dart';
import 'menu_registrar.dart';
import 'menu_counter.dart';

// Stateful widget for the DemoMenu screen.
class DemoMenu extends StatefulWidget { 
  const DemoMenu({Key? key}) : super(key: key); 
  @override 
  State<DemoMenu> createState() => _DemoMenuState(); 
} 

// State class for the DemoMenu widget.
class _DemoMenuState extends State<DemoMenu> { 
  // Key to manage the form state.
  final _formkey = GlobalKey<FormState>(); 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Demo Menu'), 
        backgroundColor: Color.fromARGB(255, 0, 77, 68), 
        foregroundColor: Colors.white, 
        centerTitle: true, 
      ), 
      body: SingleChildScrollView( 
        child: Column( 
          children: <Widget>[ 
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
                                  builder: (context) => const Pmenu(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Presiding Officer Menu', 
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
                                  builder: (context) => const RMenu(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Registrar Menu', 
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
                                  builder: (context) => const CMenu(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,0,102,88),
                              foregroundColor: Colors.white, 
                            ), 
                            child: Text( 
                              'Counter Menu', 
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