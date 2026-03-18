import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/app_provider.dart';
import '../services/database_service.dart';
import '../models/record.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Record> _selectedDayRecords = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadRecordsForDay(_selectedDay!);
  }

  Future<void> _loadRecordsForDay(DateTime day) async {
    setState(() => _isLoading = true);
    
    final provider = Provider.of<AppProvider>(context, listen: false);
    final baby = provider.currentBaby;
    
    if (baby != null) {
      final db = DatabaseService();
      final records = await db.getRecordsByDate(baby.id, day);
      setState(() {
        _selectedDayRecords = records;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 日历
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _loadRecordsForDay(selectedDay);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFFFF8A80)),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFFFF8A80)),
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8A80),
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFFF8A80).withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFFF8A80),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Color(0xFF80CBC4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            // 今日相册
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '📸 今日相册',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '0张',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFFF8A80),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildPhotoThumbnail('早', const Color(0xFFFFE0B2)),
                          _buildPhotoThumbnail('中', const Color(0xFFFFCCBC)),
                          _buildPhotoThumbnail('辅', const Color(0xFFFFF9C4)),
                          _buildPhotoThumbnail('睡', const Color(0xFFB2DFDB)),
                          _buildPhotoThumbnail('晚', const Color(0xFFE1BEE7)),
                          _buildAddPhotoButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 时间轴标题
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '⏰ ${_selectedDay?.day == DateTime.now().day ? '今日' : '${_selectedDay?.month}月${_selectedDay?.day}日'}时间轴',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8A80).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 16,
                            color: Color(0xFFFF8A80),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_selectedDayRecords.length}条记录',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFFF8A80),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 时间轴列表
            if (_isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_selectedDayRecords.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          '这一天还没有记录',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final record = _selectedDayRecords[index];
                    return _buildTimelineItem(
                      time: record.displayTime,
                      icon: record.typeIcon,
                      title: record.typeText,
                      detail: record.content ?? record.note ?? '',
                      color: _getTypeColor(record.type),
                      hasPhoto: record.hasMedia,
                      photoCount: record.photoPaths?.length ?? 0,
                      hasVideo: record.videoPath != null,
                    );
                  },
                  childCount: _selectedDayRecords.length,
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoThumbnail(String label, Color color) {
    return Container(
      width: 72,
      height: 72,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/placeholder_photo.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Container(
      width: 72,
      height: 72,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          style: BorderStyle.solid,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.grey,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String icon,
    required String title,
    required String detail,
    required Color color,
    bool hasPhoto = false,
    int photoCount = 0,
    bool hasVideo = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                if (hasPhoto || hasVideo) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (hasPhoto)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.photo,
                                size: 14,
                                color: Color(0xFFFF8A80),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$photoCount张',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFFF8A80),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (hasVideo)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.videocam,
                                size: 14,
                                color: Color(0xFF66BB6A),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '视频',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF66BB6A),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'feeding':
        return const Color(0xFFFFCCBC);
      case 'sleep':
        return const Color(0xFFB2DFDB);
      case 'food':
        return const Color(0xFFFFF9C4);
      case 'diaper':
        return const Color(0xFFD7CCC8);
      case 'temperature':
        return const Color(0xFFFFCDD2);
      case 'photo':
        return const Color(0xFFE1BEE7);
      default:
        return const Color(0xFFE0E0E0);
    }
  }
}
