class HistoryItem {
  final String id;
  final String content;
  final String type;
  final String source;
  final DateTime createdAt;

  HistoryItem({
    required this.id,
    required this.content,
    required this.type,
    required this.source,
    required this.createdAt,
  });

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      "content":content,
      'type':type,
      'source':source,
      'createdAt':createdAt.toIso8601String(),

    };
  }
  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      source: json['source'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}