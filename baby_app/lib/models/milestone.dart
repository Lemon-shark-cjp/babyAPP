class Milestone {
  final String id;
  final String babyId;
  final String title;
  final String? description;
  final int? expectedMonth; // 预期达成月龄
  final DateTime? achievedDate; // 实际达成日期
  final bool isAchieved;
  final String? photoPath;
  final String? note;
  final DateTime createdAt;

  Milestone({
    required this.id,
    required this.babyId,
    required this.title,
    this.description,
    this.expectedMonth,
    this.achievedDate,
    this.isAchieved = false,
    this.photoPath,
    this.note,
    required this.createdAt,
  });

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      id: map['id'] as String,
      babyId: map['babyId'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      expectedMonth: map['expectedMonth'] as int?,
      achievedDate: map['achievedDate'] != null 
          ? DateTime.parse(map['achievedDate'] as String) 
          : null,
      isAchieved: map['isAchieved'] == 1,
      photoPath: map['photoPath'] as String?,
      note: map['note'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'babyId': babyId,
      'title': title,
      'description': description,
      'expectedMonth': expectedMonth,
      'achievedDate': achievedDate?.toIso8601String(),
      'isAchieved': isAchieved ? 1 : 0,
      'photoPath': photoPath,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get displayDate {
    if (achievedDate != null) {
      return '${achievedDate!.year}-${achievedDate!.month.toString().padLeft(2, '0')}-${achievedDate!.day.toString().padLeft(2, '0')}';
    }
    if (expectedMonth != null) {
      return '预计${expectedMonth}月龄';
    }
    return '待达成';
  }
}

// 标准里程碑（0-3岁）
final List<Map<String, dynamic>> standardMilestones = [
  {'title': '会抬头', 'expectedMonth': 2},
  {'title': '会翻身', 'expectedMonth': 4},
  {'title': '会坐', 'expectedMonth': 6},
  {'title': '会爬', 'expectedMonth': 9},
  {'title': '会站', 'expectedMonth': 10},
  {'title': '会走', 'expectedMonth': 12},
  {'title': '会说单字', 'expectedMonth': 12},
  {'title': '长第一颗牙', 'expectedMonth': 6},
  {'title': '会挥手再见', 'expectedMonth': 9},
  {'title': '会指物', 'expectedMonth': 12},
  {'title': '会叫爸爸妈妈', 'expectedMonth': 12},
  {'title': '会自己吃饭', 'expectedMonth': 15},
  {'title': '会跑', 'expectedMonth': 18},
  {'title': '会说短句', 'expectedMonth': 24},
  {'title': '会跳', 'expectedMonth': 24},
  {'title': '会穿衣', 'expectedMonth': 30},
  {'title': '会数数', 'expectedMonth': 30},
  {'title': '会骑三轮车', 'expectedMonth': 36},
];
