import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/quick_record_buttons.dart';
import '../widgets/timeline_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            final baby = provider.currentBaby;
            final stats = provider.todayStats;
            final records = provider.todayRecords;

            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                // 顶部宝宝信息栏
                SliverToBoxAdapter(
                  child: _buildBabyCard(context, baby),
                ),

                // 快捷记录按钮
                const SliverToBoxAdapter(
                  child: QuickRecordButtons(),
                ),

                // 今日概览
                SliverToBoxAdapter(
                  child: _buildTodayOverview(stats),
                ),

                // 最近记录标题
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '📅 最近记录',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('查看全部'),
                        ),
                      ],
                    ),
                  ),
                ),

                // 时间轴列表
                if (records.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                          '今天还没有记录\n点击上方按钮开始记录吧',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final record = records[index];
                        return TimelineItem(
                          icon: record.typeIcon,
                          title: record.typeText,
                          time: record.displayTime,
                          detail: record.content ?? record.note ?? '',
                          hasPhoto: record.hasMedia,
                          photoCount: record.photoPaths?.length,
                          color: _getTypeColor(record.type),
                        );
                      },
                      childCount: records.length,
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBabyCard(BuildContext context, baby) {
    if (baby == null) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8A80), Color(0xFFFFAB91)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.add_circle, color: Colors.white, size: 48),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '添加宝宝',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '点击开始记录宝宝成长',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A80), Color(0xFFFFAB91)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8A80).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  baby.gender == 'male'
                      ? 'assets/images/baby_boy.svg'
                      : 'assets/images/baby_girl.svg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      baby.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      baby.gender == 'male' ? Icons.male : Icons.female,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  baby.ageText,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.vaccines,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '乙肝疫苗第3剂 还有3天',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayOverview(Map<String, int> stats) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 今日概览',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('🍼', '喂奶', '${stats['feeding'] ?? 0}次', const Color(0xFFFFCCBC)),
              _buildStatItem('😴', '睡眠', '${stats['sleep'] ?? 0}次', const Color(0xFFB2DFDB)),
              _buildStatItem('🥄', '辅食', '${stats['food'] ?? 0}次', const Color(0xFFFFF9C4)),
              _buildStatItem('💩', '排便', '${stats['diaper'] ?? 0}次', const Color(0xFFD7CCC8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String label, String value, Color bgColor) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
      default:
        return const Color(0xFFE1BEE7);
    }
  }
}
