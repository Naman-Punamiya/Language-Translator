import 'package:flutter/material.dart';
import 'package:language_translator/language_translation.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9df6e),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 60,),
            const Text(
              "Translator",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xff323232),),
            ),
            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Translate easy and fast into many Languages",textAlign: TextAlign.center,style: TextStyle(fontSize: 20, color: Color(0xff323232),),),
            ),
            const SizedBox(height: 60,),
            SizedBox(height: 300, child: Image.asset("assets/eng-spa2.png")),
            const SizedBox(height: 60,),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const LanguageTranslationPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff323232),
                    borderRadius: BorderRadius.circular(12)
                  ),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        "Continue",
                        // textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
