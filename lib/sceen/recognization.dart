import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
//import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({super.key, this.path});

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  TextEditingController controller =TextEditingController();

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recognize page')),

      body: _isBusy == true ?
       const Center(
        child: CircularProgressIndicator(),
      ): Container(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          maxLines: MediaQuery.of(context).size.height.toInt(),
          controller:controller,

        decoration: const InputDecoration(hintText: 'Text goes here ...'),
        ),

      ),
    );
  }
  
  Future< void> processImage(InputImage image) async {
  final textRecognizer = GoogleMlKit.vision.textRecognizer(script: TextRecognitionScript.latin);
setState(() {
  _isBusy = true;
});

  try {
    final RecognizedText recognizedText = await textRecognizer.processImage(image);

    // Obtenez le texte reconnu
    /*final originalText = recognizedText.text;

    // Traduisez le texte dans la langue du téléphone
    final detectedLanguage = recognizedText.language;

    final translatedText = await GoogleTranslator.translate(
      detectedLanguage,
      Localizations.localeOf(context).languageCode,
      originalText,
    );*/

    // Affichez le texte traduit dans le TextField
    controller.text = recognizedText.text;
  } catch (e) {
    log('Erreur lors de la reconnaissance de texte : $e');
    // Gérez l'erreur, par exemple, affichez un message à l'utilisateur
  } finally {
    setState(() {
      _isBusy = false;
    });
  }
}

}