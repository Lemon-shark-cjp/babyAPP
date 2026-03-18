class Vaccine {
  final String id;
  final String babyId;
  final String name;
  final String? description;
  final int doseNumber; // 第几剂
  final int totalDoses; // 总共几剂
  final DateTime? scheduledDate; // 计划接种日期
  final DateTime? actualDate; // 实际接种日期
  final String status; // 'pending', 'completed', 'overdue'
  final String? note;
  final DateTime createdAt;

  Vaccine({
    required this.id,
    required this.babyId,
    required this.name,
    this.description,
    required this.doseNumber,
    required this.totalDoses,
    this.scheduledDate,
    this.actualDate,
    required this.status,
    this.note,
    required this.createdAt,
  });

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map['id'] as String,
      babyId: map['babyId'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      doseNumber: map['doseNumber'] as int,
      totalDoses: map['totalDoses'] as int,
      scheduledDate: map['scheduledDate'] != null 
          ? DateTime.parse(map['scheduledDate'] as String) 
          : null,
      actualDate: map['actualDate'] != null 
          ? DateTime.parse(map['actualDate'] as String) 
          : null,
      status: map['status'] as String,
      note: map['note'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'babyId': babyId,
      'name': name,
      'description': description,
      'doseNumber': doseNumber,
      'totalDoses': totalDoses,
      'scheduledDate': scheduledDate?.toIso8601String(),
      'actualDate': actualDate?.toIso8601String(),
      'status': status,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get displayName {
    if (totalDoses > 1) {
      return '$name（第$doseNumber/$totalDoses剂）';
    }
    return name;
  }

  String get statusText {
    switch (status) {
      case 'completed':
        return '已接种';
      case 'pending':
        return '待接种';
      case 'overdue':
        return '已逾期';
      default:
        return '未知';
    }
  }

  int? get daysUntil {
    if (scheduledDate == null) return null;
    final now = DateTime.now();
    final diff = scheduledDate!.difference(now);
    return diff.inDays;
  }

  String? get countdownText {
    if (status == 'completed') return null;
    final days = daysUntil;
    if (days == null) return null;
    
    if (days < 0) {
      return '逾期${-days}天';
    } else if (days == 0) {
      return '今天';
    } else if (days == 1) {
      return '明天';
    } else if (days <= 7) {
      return '$days天后';
    } else if (days <= 30) {
      return '${days ~/ 7}周后';
    }
    return '${days ~/ 30}月后';
  }
}

// 标准疫苗计划（0-3岁）
final List<Map<String, dynamic>> standardVaccineSchedule = [
  {'name': '乙肝疫苗', 'doses': 3, 'months': [0, 1, 6]},
  {'name': '卡介苗', 'doses': 1, 'months': [0]},
  {'name': '脊灰疫苗', 'doses': 4, 'months': [2, 3, 4, 48]},
  {'name': '百白破疫苗', 'doses': 4, 'months': [3, 4, 5, 18]},
  {'name': '麻腮风疫苗', 'doses': 2, 'months': [8, 18]},
  {'name': '乙脑疫苗', 'doses': 2, 'months': [8, 24]},
  {'name': '流脑A疫苗', 'doses': 2, 'months': [6, 9]},
  {'name': '流脑A+C疫苗', 'doses': 2, 'months': [36, 72]},
  {'name': '甲肝疫苗', 'doses': 2, 'months': [18, 24]},
  {'name': '水痘疫苗', 'doses': 2, 'months': [12, 48]},
];
