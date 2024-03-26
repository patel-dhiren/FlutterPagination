class Question {
  final String id;
  final String title;
  final String type;
  final String chapter;
  final int std;
  final int sem;
  final String sub;
  final int marks;
  final String? answer;
  final String? imageUrl;
  final bool isAnswered;
  final String createdAt;
  final String updatedAt;

  Question({
    required this.id,
    required this.title,
    required this.type,
    required this.chapter,
    required this.std,
    required this.sem,
    required this.sub,
    required this.marks,
    this.answer,
    this.imageUrl,
    required this.isAnswered,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      title: json['title'],
      type: json['type'],
      chapter: json['chapter'],
      std: json['std'],
      sem: json['sem'],
      sub: json['sub'],
      marks: json['marks'],
      answer: json['answer'],
      imageUrl: json['image_url'],
      isAnswered: json['isAnswered'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
