import 'package:flutter/material.dart';
import 'package:kai_app/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String? generatedContent;
  String displayText = 'jhbvzxjkbvzscj';

  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('KAI'),
        leading: const Icon(Icons.menu),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            onPressed: () async {
              if (await speechToText.hasPermission &&
                  speechToText.isNotListening) {
                await startListening();
              } else if (speechToText.isListening) {
                final speech = await openAIService.chatGPTAPI(lastWords);
                if (speech.contains('https')) {
                  generatedContent = null;
                  setState(() {});
                } else {
                  generatedContent = speech;
                  setState(() {});
                  await systemSpeak(speech);
                }
                await stopListening();
              } else {
                initSpeechToText();
              }
            },
            label: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/virtualAssistant.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            foregroundColor: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(
                width: 250,
                style: BorderStyle.none,
              ),
            ),
            elevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
          ),
          Column(
            children: [
              Text(
                displayText,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
