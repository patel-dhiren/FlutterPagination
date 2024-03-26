import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'conntroller/question_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final QuestionController controller = Get.put(QuestionController());
  final ScrollController _scrollController = ScrollController();

  QuestionPage() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        controller.fetchQuestions(); // Fetch next page of questions
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paginated Questions')),
      body: Obx(() => ListView.builder(
        controller: _scrollController,
        itemCount: controller.questions.length + (controller.isMoreDataAvailable.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.questions.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          final question = controller.questions[index];
          return Container(
            height: 100,
            child: ListTile(
              title: Text(question.title),
              subtitle: Text(question.answer ?? 'No answer'),
            ),
          );
        },
      )),
    );
  }
}
