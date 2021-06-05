import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:clipboard/clipboard.dart';

class Translate extends StatefulWidget {
  @override
  _TranslateState createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var output;
  String dropdownValue;
  String text = "the translated text";
  String _errortext;

  static const Map<String, String> lang = {
    "Hindi": "hi",
    "English": "en",
    "Urdu": "ur",
    "Spanish": "es",
    "Telugu": "te",
    "Tamil": "ta",
    "Kannada": "kn",
    "Malayalam": "ml",
    "Punjabi": "pa",
    "Gujarati": "gu",
    "Bengali Bangla": "bn",
    "Marathi": "mr",
    "Nepali": "ne",
    "Afrikaans": "af",
    "Albanian": "sq",
    "Amharic": "am",
    "Arabic": "ar",
    "Armenian": "hy",
    "Assamese": "as",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bulgarian": "bg",
    "Bosnian": "bs",
    "Chinese": "yue",
    "Catalan Valencian": "ca",
    "Czech": "cs",
    "Danish": "da",
    "German": "de",
    "Modern Greek": "el",
    "Estonian": "et",
    "Finnish": "fi",
    "Filipino Pilipino": "fil",
    "French": "fr",
    "Galician": "gl",
    "Swiss German Alemannic Alsatian": "gsw",
    "Hebrew": "he",
    "Croatian": "hr",
    "Hungarian": "hu",
    "Indonesian": "id",
    "Icelandic": "is",
    "Italian": "it",
    "Japanese": "ja",
    "Georgian": "ka",
    "Kazakh": "kk",
    "Khmer Central Khmer": "km",
    "Korean": "ko",
    "Kirghiz Kyrgyz": "ky",
    "Lao": "lo",
    "Lithuanian": "lt",
    "Latvian": "lv",
    "Macedonian": "mk",
    "Mongolian": "mn",
    "Malay": "ms",
    "Burmese": "my",
    "Norwegian Bokmål": "nb",
    "Dutch Flemish": "nl",
    "Norwegian": "no",
    "Oriya": "or",
    "Persian": "fa",
    "Polish": "pl",
    "Pushto Pashto": "ps",
    "Portuguese": "pt",
    "Romanian Moldavian Moldovan": "ro",
    "Russian": "ru",
    "Sinhala Sinhalese": "si",
    "Slovak": "sk",
    "Slovenian": "sl",
    "Serbian": "sr",
    "Swedish": "sv",
    "Swahili": "sw",
    "Thai": "th",
    "Tagalog": "tl",
    "Turkish": "tr",
    "Ukrainian": "uk",
    "Uzbek": "uz",
    "Vietnamese": "vi",
    "Zulu": "zu",
  };

  void trans() {
    translator
        .translate(textEditingController.text, to: "$dropdownValue")
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              onChanged: (value) => {print(value)},
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: "Enter your text to be translated!",
                  border: OutlineInputBorder(),
                  errorText: _errortext,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear_rounded),
                    onPressed: () => textEditingController.clear(),
                  )),
              controller: textEditingController,
              onTap: () {
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("Choose language"),
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: lang
                              .map((string, value) {
                                return MapEntry(
                                  string,
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(string),
                                  ),
                                );
                              })
                              .values
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 200,
            height: 50,
            child: RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Icon(Icons.loop_outlined), Text("Translate")]),
                onPressed: () {
                  if (textEditingController.text.isEmpty) {
                    setState(() {
                      _errortext = "Enter the text";
                    });
                  } else {
                    setState(() {
                      _errortext = null;
                    });
                  }
                  trans();
                }),
          ),
          SizedBox(
            height: 25,
          ),
          Text('Translated Text',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 300,
              height: 200,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Center(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _text(),
                    )
                  ])))),
        ],
      ),
    ));
  }

  Widget _text() {
    if (output == null) {
      return Text(
        "Translated Text",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () async {
                        setState(() {
                          output = null;
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text("Cleared")));
                        });
                      },
                      icon: Icon(Icons.cancel))),
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () async {
                        await FlutterClipboard.copy(output.toString());
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("Copied")));
                      })),
            ],
          ),
          SelectableText(
            output.toString(),
            scrollPhysics: ClampingScrollPhysics(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      );
    }
  }
}
