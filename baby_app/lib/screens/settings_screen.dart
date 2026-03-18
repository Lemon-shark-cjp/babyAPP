import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 页面标题
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Text(
                  '👤 我的',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 用户信息
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/mother_avatar.svg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '小九妈妈',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '已记录128天 · 照片356张',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            // 我的宝宝
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '👶 我的宝宝',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBabyItem('小宝', '6个月12天', '女', true),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('添加宝宝'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFFF8A80),
                        side: const BorderSide(color: Color(0xFFFF8A80)),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 家人共享
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '👨‍👩‍👧 家人共享',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildFamilyMember('爸爸', Icons.person, const Color(0xFF90CAF9)),
                        _buildFamilyMember('奶奶', Icons.person_3, const Color(0xFFFFCCBC)),
                        _buildAddFamilyButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 设置列表
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      icon: Icons.cloud_sync,
                      iconColor: const Color(0xFF90CAF9),
                      title: '云同步与备份',
                      subtitle: '上次同步：刚刚',
                    ),
                    const Divider(height: 1, indent: 70),
                    _buildSettingItem(
                      icon: Icons.file_download,
                      iconColor: const Color(0xFF80CBC4),
                      title: '导出数据',
                      subtitle: 'Excel / PDF',
                    ),
                    const Divider(height: 1, indent: 70),
                    _buildSettingItem(
                      icon: Icons.notifications,
                      iconColor: const Color(0xFFFFCCBC),
                      title: '提醒设置',
                    ),
                    const Divider(height: 1, indent: 70),
                    _buildSettingItem(
                      icon: Icons.dark_mode,
                      iconColor: const Color(0xFFB39DDB),
                      title: '夜间模式',
                      trailing: Switch(
                        value: false,
                        onChanged: (v) {},
                        activeColor: const Color(0xFFFF8A80),
                      ),
                    ),
                    const Divider(height: 1, indent: 70),
                    _buildSettingItem(
                      icon: Icons.wifi_off,
                      iconColor: const Color(0xFFBCAAA4),
                      title: '离线模式',
                      trailing: Switch(
                        value: false,
                        onChanged: (v) {},
                        activeColor: const Color(0xFFFF8A80),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 其他
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      icon: Icons.help_outline,
                      iconColor: const Color(0xFF80CBC4),
                      title: '帮助与反馈',
                    ),
                    const Divider(height: 1, indent: 70),
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      iconColor: const Color(0xFF90CAF9),
                      title: '关于我们',
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBabyItem(String name, String age, String gender, bool isCurrent) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent ? const Color(0xFFFFF3E0) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: isCurrent
            ? Border.all(color: const Color(0xFFFF8A80).withOpacity(0.3))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isCurrent
                  ? const Color(0xFFFF8A80).withOpacity(0.2)
                  : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                gender == '女' ? Icons.female : Icons.male,
                color: isCurrent ? const Color(0xFFFF8A80) : Colors.grey,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  age,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (isCurrent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF8A80),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '当前',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFamilyMember(String name, IconData icon, Color color) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildAddFamilyButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 70,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Icon(Icons.add, color: Colors.grey, size: 28),
            ),
            const SizedBox(height: 8),
            const Text(
              '邀请',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
