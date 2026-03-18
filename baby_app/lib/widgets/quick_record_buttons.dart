import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/record.dart';
import 'record_dialogs.dart';

class QuickRecordButtons extends StatelessWidget {
  const QuickRecordButtons({super.key});

  final List<Map<String, dynamic>> buttons = const [
    {'icon': '🍼', 'label': '喂奶', 'color': Color(0xFFFFCCBC), 'type': 'feeding'},
    {'icon': '😴', 'label': '睡觉', 'color': Color(0xFFB2DFDB), 'type': 'sleep'},
    {'icon': '🥄', 'label': '辅食', 'color': Color(0xFFFFF9C4), 'type': 'food'},
    {'icon': '💩', 'label': '排便', 'color': Color(0xFFD7CCC8), 'type': 'diaper'},
    {'icon': '🌡️', 'label': '体温', 'color': Color(0xFFFFCDD2), 'type': 'temperature'},
    {'icon': '📷', 'label': '拍照', 'color': Color(0xFFE1BEE7), 'type': 'photo'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⚡ 快捷记录',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons.sublist(0, 3).map((btn) => _buildButton(context, btn)).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons.sublist(3, 6).map((btn) => _buildButton(context, btn)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, Map<String, dynamic> btn) {
    return GestureDetector(
      onTap: () => _handleButtonTap(context, btn['type'] as String),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: btn['color'] as Color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (btn['color'] as Color).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                btn['icon'] as String,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            btn['label'] as String,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleButtonTap(BuildContext context, String type) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final baby = provider.currentBaby;
    
    if (baby == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先添加宝宝信息')),
      );
      return;
    }

    switch (type) {
      case 'feeding':
        _showFeedingDialog(context, baby.id, provider);
        break;
      case 'sleep':
        _showSleepDialog(context, baby.id, provider);
        break;
      case 'food':
        _showFoodDialog(context, baby.id, provider);
        break;
      case 'diaper':
        _showDiaperDialog(context, baby.id, provider);
        break;
      case 'temperature':
        _showTemperatureDialog(context, baby.id, provider);
        break;
      case 'photo':
        _showPhotoPicker(context, baby.id, provider);
        break;
    }
  }

  void _showFeedingDialog(BuildContext context, String babyId, AppProvider provider) {
    showDialog(
      context: context,
      builder: (context) => FeedingDialog(
        onSave: (data) => _saveFeedingRecord(context, babyId, data, provider),
      ),
    );
  }

  void _showSleepDialog(BuildContext context, String babyId, AppProvider provider) {
    showDialog(
      context: context,
      builder: (context) => SleepDialog(
        onSave: (data) => _saveSleepRecord(context, babyId, data, provider),
      ),
    );
  }

  void _showFoodDialog(BuildContext context, String babyId, AppProvider provider) {
    showDialog(
      context: context,
      builder: (context) => FoodDialog(
        onSave: (data) => _saveFoodRecord(context, babyId, data, provider),
      ),
    );
  }

  void _showDiaperDialog(BuildContext context, String babyId, AppProvider provider) {
    showDialog(
      context: context,
      builder: (context) => DiaperDialog(
        onSave: (data) => _saveDiaperRecord(context, babyId, data, provider),
      ),
    );
  }

  void _showTemperatureDialog(BuildContext context, String babyId, AppProvider provider) {
    // TODO: 实现体温记录弹窗
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('体温记录功能开发中')),
    );
  }

  void _showPhotoPicker(BuildContext context, String babyId, AppProvider provider) {
    // TODO: 实现图片选择
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('图片选择功能开发中')),
    );
  }

  Future<void> _saveFeedingRecord(
    BuildContext context,
    String babyId,
    Map<String, dynamic> data,
    AppProvider provider,
  ) async {
    final now = DateTime.now();
    final record = Record(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      babyId: babyId,
      type: 'feeding',
      startTime: now.subtract(Duration(minutes: data['duration'] ?? 15)),
      endTime: now,
      content: data['feedingType'] == 'breast' 
          ? '母乳亲喂 - ${data['side']}' 
          : '奶粉瓶喂',
      amount: data['amount']?.toDouble(),
      unit: data['amount'] != null ? 'ml' : null,
      note: data['note'],
      createdAt: now,
    );

    await provider.addRecord(record);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('喂奶记录已保存')),
      );
    }
  }

  Future<void> _saveSleepRecord(
    BuildContext context,
    String babyId,
    Map<String, dynamic> data,
    AppProvider provider,
  ) async {
    final record = Record(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      babyId: babyId,
      type: 'sleep',
      startTime: data['startTime'],
      endTime: data['endTime'],
      note: data['note'],
      createdAt: DateTime.now(),
    );

    await provider.addRecord(record);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('睡眠记录已保存')),
      );
    }
  }

  Future<void> _saveFoodRecord(
    BuildContext context,
    String babyId,
    Map<String, dynamic> data,
    AppProvider provider,
  ) async {
    final record = Record(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      babyId: babyId,
      type: 'food',
      startTime: DateTime.now(),
      content: data['food'],
      amount: null,
      unit: data['amount'],
      note: '${data['reaction']}${data['note'] != null ? ' - ${data['note']}' : ''}',
      createdAt: DateTime.now(),
    );

    await provider.addRecord(record);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('辅食记录已保存')),
      );
    }
  }

  Future<void> _saveDiaperRecord(
    BuildContext context,
    String babyId,
    Map<String, dynamic> data,
    AppProvider provider,
  ) async {
    final record = Record(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      babyId: babyId,
      type: 'diaper',
      startTime: DateTime.now(),
      content: '${data['diaperType']} - ${data['color'] ?? ''} ${data['consistency'] ?? ''}',
      note: data['note'],
      createdAt: DateTime.now(),
    );

    await provider.addRecord(record);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('排便记录已保存')),
      );
    }
  }
}
