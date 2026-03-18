class Record {
  final String id;
  final String babyId;
  final String type; // 'feeding', 'sleep', 'food', 'diaper', 'temperature', 'photo', 'note'
  final DateTime startTime;
  final DateTime? endTime;
  final String? content;
  final double? amount; // 奶量、食量等
  final String? unit; // 'ml', 'g', 'min', 'hour', '°C'
  final String? note;
  final List<String>? photoPaths;
  final String? videoPath;
  final DateTime createdAt;

  Record({
    required this.id,
    required this.babyId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.content,
    this.amount,
    this.unit,
    this.note,
    this.photoPaths,
    this.videoPath,
    required this.createdAt,
  });

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      id: map['id'] as String,
      babyId: map['babyId'] as String,
      type: map['type'] as String,
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime'] as String) : null,
      content: map['content'] as String?,
      amount: map['amount'] != null ? (map['amount'] as num).toDouble() : null,
      unit: map['unit'] as String?,
      note: map['note'] as String?,
      photoPaths: map['photoPaths'] != null 
          ? (map['photoPaths'] as String).split(',') 
          : null,
      videoPath: map['videoPath'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'babyId': babyId,
      'type': type,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'content': content,
      'amount': amount,
      'unit': unit,
      'note': note,
      'photoPaths': photoPaths?.join(','),
      'videoPath': videoPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get typeText {
    switch (type) {
      case 'feeding':
        return '喂奶';
      case 'sleep':
        return '睡觉';
      case 'food':
        return '辅食';
      case 'diaper':
        return '排便';
      case 'temperature':
        return '体温';
      case 'photo':
        return '拍照';
      case 'note':
        return '记事';
      default:
        return '记录';
    }
  }

  String get typeIcon {
    switch (type) {
      case 'feeding':
        return '🍼';
      case 'sleep':
        return '😴';
      case 'food':
        return '🥄';
      case 'diaper':
        return '💩';
      case 'temperature':
        return '🌡️';
      case 'photo':
        return '📷';
      case 'note':
        return '📝';
      default:
        return '📋';
    }
  }

  String get displayTime {
    final hour = startTime.hour.toString().padLeft(2, '0');
    final minute = startTime.minute.toString().padLeft(2, '0');
    
    if (endTime != null) {
      final endHour = endTime!.hour.toString().padLeft(2, '0');
      final endMinute = endTime!.minute.toString().padLeft(2, '0');
      return '$hour:$minute-$endHour:$endMinute';
    }
    return '$hour:$minute';
  }

  String? get durationText {
    if (endTime == null) return null;
    final diff = endTime!.difference(startTime);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    
    if (hours > 0) {
      return '$hours小时$minutes分钟';
    }
    return '$minutes分钟';
  }

  bool get hasMedia => (photoPaths != null && photoPaths!.isNotEmpty) || videoPath != null;
}
