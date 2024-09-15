import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'global.dart' as globals;

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslationPage> {
  
  var languages = ["Arabic","Bengali","Czech","Dutch","English","French","German","Gujarati","Hindi","Italian","Indonesian","Japanese","Kannada","Korean","Lithuanian","Malayalam","Marathi","Norwegian","Polish","Portuguese(B)","Portuguese(P)","Romanian","Russian","Serbian","Spanish","Swedish","Tamil","Telugu","Thai","Turkish","Urdu","Ukrainian","Vietnamese","Welsh",];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();
  
  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input,from: src,to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src=="--" || dest=="--"){
      setState(() {
        output = "Fail To Translate";
      });
    }
    globals.output = output;
  }

  String getLanguageCode(String language){
    switch(language){
      case "Arabic":
        return "ar";
      case "Bengali":
        return "bn";
      case "Czech":
        return "cs";
      case "Dutch":
        return "nl";
      case "English":
        return "en";
      case "French":
        return "fr";
      case "German":
        return "de";
      case "Gujarati":
        return "gu";
      case "Hindi":
        return "hi";
      case "Italian":
        return "it";
      case "Indonesian":
        return "id";
      case "Japanese":
        return "ja";
      case "Kannada":
        return "kn";
      case "Korean":
        return "ko";
      case "Lithuanian":
        return "lt";
      case "Malayalam":
        return "ml";
      case "Marathi":
        return "mr";
      case "Norwegian":
        return "no";
      case "Polish":
        return "pl";
      case "Romanian":
        return "ro";
      case "Russian":
        return "ru";
      case "Serbian":
        return "sr";
      case "Spanish":
        return "es";
      case "Swedish":
        return "sv";
      case "Tamil":
        return "ta";
      case "Telugu":
        return "te";
      case "Thai":
        return "th";
      case "Turkish":
        return "tr";
      case "Urdu":
        return "ur";
      case "Ukrainian":
        return "uk";
      case "Vietnamese":
        return "vi";
      case "Welsh":
        return "cy";
      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Text("Language Translator"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 41, 86, 153),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                  child: Image(image: AssetImage("assets/translation.png"),color: Colors.white,),
                ),
                const SizedBox(height: 75,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      focusColor: Colors.white,
                      items: languages.map((String dropDownStringItem){
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child : Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          originLanguage = value!;
                        });
                      },
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(originLanguage,style: const TextStyle(color: Colors.white),),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                    const SizedBox(width: 20,),
                    const Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                    const SizedBox(width: 20,),
                    DropdownButton(
                      focusColor: Colors.white,
                      items: languages.map((String dropDownStringItem){
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child : Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          destinationLanguage = value!;
                        });
                      },
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(destinationLanguage,style: const TextStyle(color: Colors.white),),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                Padding(padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Please Enter Your Text...",
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1)),
                    errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please Enter Text To Translate";
                    }
                    return null;
                  },
                ),
                ),
                const SizedBox(height: 25,),
                Center(
                  child: Padding(padding: const EdgeInsets.all(8),
                  child: Row(
                      children: [
                        const SizedBox(width:16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2b3c5a),foregroundColor: Colors.white),
                          onPressed: (){
                            translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
                          }, 
                          child: const Text("Translate",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Rubik",height: 3,letterSpacing: 1.5),)),
                        const SizedBox(width: 40,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2b3c5a),foregroundColor: Colors.white),
                          onPressed: (){
                            Clipboard.setData(ClipboardData(text: globals.output));
                          }, 
                          child: const Text("Copy Text",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Rubik",height: 3,letterSpacing: 1.5),)),  
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  "\n$output",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
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