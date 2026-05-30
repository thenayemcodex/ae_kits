class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String page;
  final bool isRead;
  final int date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.page,
    required this.isRead,
    required this.date,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? page,
    bool? isRead,
    int? date,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      page: page ?? this.page,
      isRead: isRead ?? this.isRead,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'page': page,
      'isRead': isRead,
      'date': date,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      page: map['page'] ?? '',
      isRead: map['isRead'] ?? false,
      date: map['date'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, body: $body, page: $page, isRead: $isRead, date: $date)';
  }

}
