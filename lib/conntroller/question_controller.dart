import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/question.dart'; // Adjust the import path as needed

class QuestionController extends GetxController {
  var questions = <Question>[].obs;
  int currentPage = 1;
  var isLoading = false.obs; // Use RxBool for consistency
  var isMoreDataAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void fetchQuestions() async {
    if (isLoading.value || !isMoreDataAvailable.value) return;
    isLoading.value = true;

    var url = 'https://paper-generation.onrender.com/api/question?page=$currentPage&standard=1&semester=1&subject=English&limit=10';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      var fetchedQuestions = (data['questions'] as List)
          .map((json) => Question.fromJson(json))
          .toList();

      if (fetchedQuestions.isNotEmpty) {
        questions.addAll(fetchedQuestions);
        currentPage++;
        isMoreDataAvailable.value = currentPage < data['totalPages'];
      } else {
        isMoreDataAvailable.value = false;
      }
    }

    isLoading.value = false;
  }
}

