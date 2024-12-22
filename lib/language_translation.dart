import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:language_translator/languages.dart';
import 'package:translator/translator.dart';
import 'global.dart' as globals;

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslationPage> {
  late Box favoritesBox = Hive.box('favorites');

  List<String> favorigin = [];
  List<String> favdestination = [];

  final box = Hive.box('favorites');

  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  var languages = [
    "Arabic",
    "Bengali",
    "Czech",
    "Dutch",
    "English",
    "French",
    "German",
    "Gujarati",
    "Hindi",
    "Italian",
    "Indonesian",
    "Japanese",
    "Kannada",
    "Korean",
    "Lithuanian",
    "Malayalam",
    "Marathi",
    "Norwegian",
    "Polish",
    "Portuguese(B)",
    "Portuguese(P)",
    "Romanian",
    "Russian",
    "Serbian",
    "Spanish",
    "Swedish",
    "Tamil",
    "Telugu",
    "Thai",
    "Turkish",
    "Urdu",
    "Ukrainian",
    "Vietnamese",
    "Welsh",
  ];

  @override
  void initState() {
    super.initState();
    initializeHive();
  }

  Future<void> initializeHive() async {
    favoritesBox = Hive.box('favorites');
    _loadFavorites();
  }

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == "--" || dest == "--") {
      setState(() {
        output = "Fail To Translate";
      });
    }
    globals.output = output;
  }

  void addToFavorites(String origin, String destination) {
    box.add({'origin': origin, 'destination': destination});
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      final favorites = box.values.toList();
      favorigin = favorites.map((e) => e['origin'] as String).toList();
      favdestination =
          favorites.map((e) => e['destination'] as String).toList();
    });
  }

  void removeFromFavorites(int index) {
    box.deleteAt(index);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            color: Colors.white,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home, color: Color(0xff323232)),
                  child: Text(
                    "Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.star_rounded, color: Color(0xff323232)),
                  child: Text(
                    "Favorites",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // Tab(icon: Icon(Icons.favorite),text: "Favourite",),
              ],
            ),
          ),
          backgroundColor: const Color(0xFFf9df6e),
          appBar: AppBar(
            title: const Text(
              "Translator",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xff323232),
            elevation: 0,
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      height: 175,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff323232),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(20),
                              focusColor: const Color(0xFFf9df6e),
                              items: languages.map((String dropDownStringItem) {
                                return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: const TextStyle(
                                        color: Color(0xFFf9df6e)),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  originLanguage = value!;
                                });
                              },
                              iconDisabledColor: const Color(0xFFf9df6e),
                              iconEnabledColor: const Color(0xFFf9df6e),
                              hint: Text(
                                originLanguage,
                                style: const TextStyle(
                                    color: Color(0xFFf9df6e), fontSize: 14),
                              ),
                              dropdownColor: const Color(0xff323232),
                              icon: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                maxLines: null,
                                expands: true,
                                cursorColor: const Color(0xff323232),
                                autofocus: false,
                                style: const TextStyle(
                                    color: Color(0xff323232),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Please Enter Your Text...",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff323232),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                                controller: languageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Text To Translate";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff323232),
                              foregroundColor: const Color(0xFFf9df6e),
                            ),
                            onPressed: () {
                              translate(
                                  getLanguageCode(originLanguage),
                                  getLanguageCode(destinationLanguage),
                                  languageController.text.toString());
                            },
                            child: const Text(
                              "Translate",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Rubik",
                                  height: 3,
                                  letterSpacing: 1.5),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff323232),
                              foregroundColor: const Color(0xFFf9df6e),
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: globals.output));
                            },
                            child: const Text(
                              "Copy Text",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Rubik",
                                  height: 3,
                                  letterSpacing: 1.5),
                            )),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      height: 175,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 110,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff323232),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(20),
                                  focusColor: const Color(0xFFf9df6e),
                                  items: languages
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem(
                                      value: dropDownStringItem,
                                      child: Text(
                                        dropDownStringItem,
                                        style: const TextStyle(
                                            color: Color(0xFFf9df6e)),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      destinationLanguage = value!;
                                    });
                                  },
                                  iconDisabledColor: const Color(0xFFf9df6e),
                                  iconEnabledColor: const Color(0xFFf9df6e),
                                  hint: Text(
                                    destinationLanguage,
                                    style: const TextStyle(
                                        color: Color(0xFFf9df6e), fontSize: 14),
                                  ),
                                  dropdownColor: const Color(0xff323232),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                ),
                              ),
                              output == ""
                                  ? Container()
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!favorigin.contains(
                                                  languageController.text) ||
                                              !favdestination
                                                  .contains(output)) {
                                            addToFavorites(
                                                languageController.text,
                                                output);
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.star_rounded,
                                        color: Colors.grey,
                                      )),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: output == ""
                                  ? const Text(
                                      "Output will be displayed here..",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xff323232),
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  : Text(
                                      output,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Color(0xff323232),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: 90,
                              width: 90,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff323232),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(Icons.edit, color: Color(0xFFf9df6e)),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Write",
                                      style: TextStyle(
                                          color: Color(0xFFf9df6e),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                          Container(
                              height: 90,
                              width: 90,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff323232),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.radio_button_checked,
                                      color: Color(0xFFf9df6e),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Record",
                                      style: TextStyle(
                                          color: Color(0xFFf9df6e),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                          Container(
                              height: 90,
                              width: 90,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff323232),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.document_scanner,
                                      color: Color(0xFFf9df6e),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Scan",
                                      style: TextStyle(
                                          color: Color(0xFFf9df6e),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ]),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: favorigin.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(favorigin[index]),
                          subtitle: Text(favdestination[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                favorigin.removeAt(index);
                                favdestination.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    }),
              ),
            )
          ])),
    );
  }
}
