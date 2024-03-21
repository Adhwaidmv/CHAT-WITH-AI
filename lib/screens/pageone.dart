import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gemini_ai/models/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: Key);
  TextEditingController controller = TextEditingController();
  static const Key = 'AIzaSyCIcgCo7YzxsSwhgsm-DFjld9TMTfEbjFU';
  void sentmessage() async {
    messagelist.add(
        Message(isuser: true, Chat: controller.text, date: DateTime.now()));
    final content = [Content.text(controller.text)];
    final response = await model.generateContent(content);
    messagelist.add(Message(
        isuser: false, Chat: response.text ?? '', date: DateTime.now()));
    controller.clear();
    setState(() {});
  }

  List<Message> messagelist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADHWAID.AI'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: messagelist.length,
            itemBuilder: (context, index) => BubbleNormal(
              bubbleRadius: .5,
              color: Colors.blue,
              tail: false,
              seen: true,
              text: messagelist[index].Chat,
              isSender: messagelist[index].isuser,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Gap(15),
                GestureDetector(
                  child: Icon(Icons.send),
                  onTap: () {
                    sentmessage();
                  },
                ),
              ],
            ),
          ),
          Gap(15),
        ],
      ),
    );
  }
}
