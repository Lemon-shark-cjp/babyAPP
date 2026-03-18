import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 喂奶记录弹窗
class FeedingDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const FeedingDialog({super.key, required this.onSave});

  @override
  State<FeedingDialog> createState() => _FeedingDialogState();
}

class _FeedingDialogState extends State<FeedingDialog> {
  String _type = 'breast'; // breast, bottle
  int _duration = 15;
  int _amount = 120;
  String _side = 'left'; // left, right, both
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Text('🍼', style: TextStyle(fontSize: 24)),
          SizedBox(width: 8),
          Text('记录喂奶'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 喂养方式选择
            const Text('喂养方式', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTypeButton('母乳亲喂', 'breast', Icons.woman),
                const SizedBox(width: 8),
                _buildTypeButton('奶粉瓶喂', 'bottle', Icons.local_drink),
              ],
            ),
            const SizedBox(height: 20),

            // 根据类型显示不同输入
            if (_type == 'breast') ...[
              const Text('喂奶时长（分钟）', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _duration = (_duration - 5).clamp(5, 60)),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Expanded(
                    child: Text(
                      '$_duration',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _duration = (_duration + 5).clamp(5, 60)),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('喂奶侧', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildSideButton('左边', 'left'),
                  const SizedBox(width: 8),
                  _buildSideButton('右边', 'right'),
                  const SizedBox(width: 8),
                  _buildSideButton('两边', 'both'),
                ],
              ),
            ] else ...[
              const Text('奶量（ml）', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _amount = (_amount - 30).clamp(30, 300)),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Expanded(
                    child: Text(
                      '$_amount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _amount = (_amount + 30).clamp(30, 300)),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),
            const Text('备注（可选）', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: '添加备注...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8A80),
            foregroundColor: Colors.white,
          ),
          child: const Text('保存'),
        ),
      ],
    );
  }

  Widget _buildTypeButton(String label, String type, IconData icon) {
    final isSelected = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF8A80) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.grey),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSideButton(String label, String side) {
    final isSelected = _side == side;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _side = side),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF8A80) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    final data = {
      'type': 'feeding',
      'feedingType': _type,
      'duration': _type == 'breast' ? _duration : null,
      'amount': _type == 'bottle' ? _amount : null,
      'side': _type == 'breast' ? _side : null,
      'note': _noteController.text,
    };
    widget.onSave(data);
    Navigator.pop(context);
  }
}

// 睡眠记录弹窗
class SleepDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const SleepDialog({super.key, required this.onSave});

  @override
  State<SleepDialog> createState() => _SleepDialogState();
}

class _SleepDialogState extends State<SleepDialog> {
  DateTime _startTime = DateTime.now().subtract(const Duration(hours: 1));
  DateTime _endTime = DateTime.now();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final duration = _endTime.difference(_startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    return AlertDialog(
      title: const Row(
        children: [
          Text('😴', style: TextStyle(fontSize: 24)),
          SizedBox(width: 8),
          Text('记录睡眠'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 开始时间
            const Text('开始时间', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildTimePicker(_startTime, (time) => setState(() => _startTime = time)),
            
            const SizedBox(height: 20),
            
            // 结束时间
            const Text('结束时间', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildTimePicker(_endTime, (time) => setState(() => _endTime = time)),
            
            const SizedBox(height: 20),
            
            // 睡眠时长
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFB2DFDB).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer, color: Color(0xFF4DB6AC)),
                  const SizedBox(width: 8),
                  Text(
                    '睡眠时长: ${hours}小时${minutes}分钟',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4DB6AC),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text('备注（可选）', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: '添加备注...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF80CBC4),
            foregroundColor: Colors.white,
          ),
          child: const Text('保存'),
        ),
      ],
    );
  }

  Widget _buildTimePicker(DateTime time, Function(DateTime) onChanged) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(time),
        );
        if (picked != null) {
          onChanged(DateTime(
            time.year, time.month, time.day,
            picked.hour, picked.minute,
          ));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18),
            ),
            const Icon(Icons.access_time, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _save() {
    final data = {
      'type': 'sleep',
      'startTime': _startTime,
      'endTime': _endTime,
      'note': _noteController.text,
    };
    widget.onSave(data);
    Navigator.pop(context);
  }
}

// 辅食记录弹窗
class FoodDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const FoodDialog({super.key, required this.onSave});

  @override
  State<FoodDialog> createState() => _FoodDialogState();
}

class _FoodDialogState extends State<FoodDialog> {
  final _foodController = TextEditingController();
  final _amountController = TextEditingController();
  String _reaction = 'good'; // good, normal, bad
  final _noteController = TextEditingController();

  final List<String> quickFoods = [
    '米粉', '南瓜泥', '胡萝卜泥', '土豆泥', '苹果泥', '香蕉泥', '蛋黄', '肉泥'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Text('🥄', style: TextStyle(fontSize: 24)),
          SizedBox(width: 8),
          Text('记录辅食'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('食物内容', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _foodController,
              decoration: const InputDecoration(
                hintText: '例如：米粉+南瓜泥',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: quickFoods.map((food) => _buildQuickFoodChip(food)).toList(),
            ),
            
            const SizedBox(height: 20),
            const Text('食量', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                hintText: '例如：大半碗、50g',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text('宝宝反应', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildReactionButton('😋', '很喜欢', 'good'),
                const SizedBox(width: 8),
                _buildReactionButton('😐', '一般', 'normal'),
                const SizedBox(width: 8),
                _buildReactionButton('😣', '不喜欢', 'bad'),
              ],
            ),

            const SizedBox(height: 20),
            const Text('备注（可选）', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: '添加备注...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFB74D),
            foregroundColor: Colors.white,
          ),
          child: const Text('保存'),
        ),
      ],
    );
  }

  Widget _buildQuickFoodChip(String food) {
    return GestureDetector(
      onTap: () {
        final current = _foodController.text;
        if (current.isEmpty) {
          _foodController.text = food;
        } else {
          _foodController.text = '$current+$food';
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          food,
          style: const TextStyle(fontSize: 13, color: Color(0xFFFF8A80)),
        ),
      ),
    );
  }

  Widget _buildReactionButton(String emoji, String label, String value) {
    final isSelected = _reaction == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _reaction = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFB74D) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    final data = {
      'type': 'food',
      'food': _foodController.text,
      'amount': _amountController.text,
      'reaction': _reaction,
      'note': _noteController.text,
    };
    widget.onSave(data);
    Navigator.pop(context);
  }
}

// 排便记录弹窗
class DiaperDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const DiaperDialog({super.key, required this.onSave});

  @override
  State<DiaperDialog> createState() => _DiaperDialogState();
}

class _DiaperDialogState extends State<DiaperDialog> {
  String _type = 'pee'; // pee, poop, both
  String _color = 'yellow'; // yellow, green, brown
  String _consistency = 'normal'; // normal, loose, hard
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Text('💩', style: TextStyle(fontSize: 24)),
          SizedBox(width: 8),
          Text('记录排便'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('类型', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTypeButton('💧 小便', 'pee'),
                const SizedBox(width: 8),
                _buildTypeButton('💩 大便', 'poop'),
                const SizedBox(width: 8),
                _buildTypeButton('都有', 'both'),
              ],
            ),
            
            if (_type != 'pee') ...[
              const SizedBox(height: 20),
              const Text('颜色', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildColorButton('黄色', 'yellow', Colors.yellow),
                  const SizedBox(width: 8),
                  _buildColorButton('绿色', 'green', Colors.green),
                  const SizedBox(width: 8),
                  _buildColorButton('棕色', 'brown', Colors.brown),
                ],
              ),
              
              const SizedBox(height: 20),
              const Text('性状', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildConsistencyButton('正常', 'normal'),
                  const SizedBox(width: 8),
                  _buildConsistencyButton('稀便', 'loose'),
                  const SizedBox(width: 8),
                  _buildConsistencyButton('干硬', 'hard'),
                ],
              ),
            ],

            const SizedBox(height: 20),
            const Text('备注（可选）', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: '添加备注...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8D6E63),
            foregroundColor: Colors.white,
          ),
          child: const Text('保存'),
        ),
      ],
    );
  }

  Widget _buildTypeButton(String label, String type) {
    final isSelected = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF8D6E63) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(String label, String color, Color bgColor) {
    final isSelected = _color == color;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _color = color),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? bgColor : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: bgColor) : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsistencyButton(String label, String consistency) {
    final isSelected = _consistency == consistency;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _consistency = consistency),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF8D6E63) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    final data = {
      'type': 'diaper',
      'diaperType': _type,
      'color': _type != 'pee' ? _color : null,
      'consistency': _type != 'pee' ? _consistency : null,
      'note': _noteController.text,
    };
    widget.onSave(data);
    Navigator.pop(context);
  }
}
