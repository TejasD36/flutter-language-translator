import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationScreen extends StatefulWidget {
  const LanguageTranslationScreen({super.key});

  @override
  State<LanguageTranslationScreen> createState() =>
      _LanguageTranslationScreenState();
}

class _LanguageTranslationScreenState extends State<LanguageTranslationScreen> {
  var languages = [
    'English',
    'French',
    'Hindi',
    'Japanese',
    'Korean',
    'Marathi',
    'Russian',
    'Spanish'
  ];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';

  TextEditingController languageController = TextEditingController();

  void translate (String src, String dest, String input) async{
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input,from: src,to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src == '--' || dest == '--'){
      setState(() {
        output = "Fail to Translate";
      });
    }
  }

  String getLanguageCode (String language){
    if(language == 'English'){
      return "en";
    }
    else if(language == 'French'){
      return "fr";
    }
    else if(language == 'Hindi'){
      return "hi";
    }
    else if(language == 'Japanese'){
      return "ja";
    }
    else if(language == 'Korean'){
      return "ko";
    }
    else if(language == 'Marathi'){
      return "mr";
    }
    else if(language == 'Russian'){
      return "ru";
    }
    else if(language == 'Spanish'){
      return "es";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Language Translator",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        originLanguage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.black12,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      items: languages.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          originLanguage = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    const Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    DropdownButton(
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        destinationLanguage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.black12,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      items: languages.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          destinationLanguage = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Padding(
                    padding:const EdgeInsets.all(8),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      autofocus: false,
                      style:const TextStyle(
                        color: Colors.white
                      ),
                      decoration:const InputDecoration(
                        labelText: 'Pleas Enter your text',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        )
                      ),
                      controller: languageController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please Enter text to Translate';
                        }
                        return null;
                      },

                    ),
                ),
                Padding(
                    padding:const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2b3c5a),
                      ),
                      onPressed: (){
                        translate(getLanguageCode(originLanguage),getLanguageCode(destinationLanguage), languageController.text.toString());
                      },
                      child:const Text('Translate'),
                    ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Text(
                  "\n$output",
                  style:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
