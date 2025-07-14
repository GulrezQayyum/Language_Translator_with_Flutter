import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  final languages = {
    'English',
    'Hindi',
    'French',
    'Spanish',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Russian',
    'Urdu',
    'Arabic',
    'Italian',
    'Portuguese',
    'Turkish',
  };
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = "";
  final TextEditingController languageController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    languageController.dispose();
    super.dispose();
  }

  Future<void> translate(String scr, String dest, String input) async {
    if (scr == '--' || dest == '--' || input.isEmpty) {
      setState(() {
        output = "Please select valid languages and enter text to translate.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      output = "";
    });

    try {
      final translator = GoogleTranslator();
      final translation = await translator.translate(
        input,
        from: scr,
        to: dest,
      );

      setState(() {
        output = translation.text;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        output = "Translation failed: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'Hindi':
        return 'hi';
      case 'French':
        return 'fr';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      case 'Chinese':
        return 'zh';
      case 'Japanese':
        return 'ja';
      case 'Korean':
        return 'ko';
      case 'Russian':
        return 'ru';
      case 'Urdu':
        return 'ur';
      case 'Arabic':
        return 'ar';
      case 'Italian':
        return 'it';
      case 'Portuguese':
        return 'pt';
      case 'Turkish':
        return 'tr';
      default:
        return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Language Translator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    dropdownColor: const Color.fromARGB(255, 72, 111, 121),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        languages.map((String language) {
                          return DropdownMenuItem(
                            value: language,
                            child: Text(
                              language,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        originLanguage = newValue!;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.blueGrey,
                    size: 30,
                  ),
                  const SizedBox(width: 20),
                  DropdownButton(
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    dropdownColor: const Color.fromARGB(255, 72, 111, 121),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        languages.map((String language) {
                          return DropdownMenuItem(
                            value: language,
                            child: Text(
                              language,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        destinationLanguage = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: languageController,
                decoration: InputDecoration(
                  labelText: 'Enter text to translate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueGrey),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : () {
                          translate(
                            getLanguageCode(originLanguage),
                            getLanguageCode(destinationLanguage),
                            languageController.text,
                          );
                        },
                child:
                    isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                          'Translate',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
              ),
              const SizedBox(height: 20),
              Text(
                output,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
