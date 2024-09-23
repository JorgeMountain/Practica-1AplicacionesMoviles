
import 'package:flutter/material.dart';
import 'package:nota_final_curso_dispositivos/pages/notas_final.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future<void> _closeSplash() async{
    Future.delayed(const Duration(seconds: 2), () async{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> const NotasFinal())
      );
    });
  }
  @override

  void initState(){
    _closeSplash();
    super.initState();
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/calificaciones.png'),
        ),
      ),
    );
  }
}
