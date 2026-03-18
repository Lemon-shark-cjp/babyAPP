class Baby {
  final String id;
  final String name;
  final String gender; // 'male' or 'female'
  final DateTime birthDate;
  final String? avatarPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Baby({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    this.avatarPath,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory Baby.fromMap(Map<String, dynamic> map) {
    return Baby(
      id: map['id'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      avatarPath: map['avatarPath'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      isActive: map['isActive'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'avatarPath': avatarPath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive ? 1 : 0,
    };
  }

  String get ageText {
    final now = DateTime.now();
    final diff = now.difference(birthDate);
    final days = diff.inDays;
    
    if (days < 30) {
      return '$days天';
    } else if (days < 365) {
      final months = days ~/ 30;
      final remainingDays = days % 30;
      if (remainingDays > 0) {
        return '$months个月$remainingDays天';
      }
      return '$months个月';
    } else {
      final years = days ~/ 365;
      final months = (days % 365) ~/ 30;
      if (months > 0) {
        return '$years岁$months个月';
      }
      return '$years岁';
    }
  }

  String get zodiacSign {
    final month = birthDate.month;
    final day = birthDate.day;
    
    const signs = [
      '摩羯座', '水瓶座', '双鱼座', '白羊座', '金牛座', '双子座',
      '巨蟹座', '狮子座', '处女座', '天秤座', '天蝎座', '射手座', '摩羯座'
    ];
    const days = [20, 19, 21, 20, 21, 22, 23, 23, 23, 23, 22, 22];
    
    if (day < days[month - 1]) {
      return signs[month - 1];
    }
    return signs[month];
  }

  Baby copyWith({
    String? id,
    String? name,
    String? gender,
    DateTime? birthDate,
    String? avatarPath,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Baby(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      avatarPath: avatarPath ?? this.avatarPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
