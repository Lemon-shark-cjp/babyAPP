class GrowthData {
  final String id;
  final String babyId;
  final DateTime date;
  final double? weight; // kg
  final double? height; // cm
  final double? headCircumference; // cm
  final String? note;
  final DateTime createdAt;

  GrowthData({
    required this.id,
    required this.babyId,
    required this.date,
    this.weight,
    this.height,
    this.headCircumference,
    this.note,
    required this.createdAt,
  });

  factory GrowthData.fromMap(Map<String, dynamic> map) {
    return GrowthData(
      id: map['id'] as String,
      babyId: map['babyId'] as String,
      date: DateTime.parse(map['date'] as String),
      weight: map['weight'] != null ? (map['weight'] as num).toDouble() : null,
      height: map['height'] != null ? (map['height'] as num).toDouble() : null,
      headCircumference: map['headCircumference'] != null 
          ? (map['headCircumference'] as num).toDouble() 
          : null,
      note: map['note'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'babyId': babyId,
      'date': date.toIso8601String(),
      'weight': weight,
      'height': height,
      'headCircumference': headCircumference,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  double? get bmi {
    if (weight == null || height == null) return null;
    final heightInMeter = height! / 100;
    return weight! / (heightInMeter * heightInMeter);
  }

  // WHO生长标准百分位（简化版）
  String? getWeightPercentile(String gender) {
    if (weight == null) return null;
    // 这里应该根据WHO标准表查询，简化返回
    if (weight! < 5) return 'P3';
    if (weight! < 7) return 'P25';
    if (weight! < 9) return 'P50';
    if (weight! < 11) return 'P75';
    return 'P97';
  }
}
