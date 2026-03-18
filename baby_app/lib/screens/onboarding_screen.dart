import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/onboarding_1.svg',
      'title': '记录宝宝成长点滴',
      'desc': '喂奶、睡眠、辅食、排便，每一个重要时刻都不错过',
    },
    {
      'image': 'assets/images/onboarding_2.svg',
      'title': '科学管理喂养记录',
      'desc': '日历视图、数据统计，让育儿更有条理',
    },
    {
      'image': 'assets/images/onboarding_3.svg',
      'title': '全家共享成长喜悦',
      'desc': '邀请家人一起记录，共同见证宝宝成长',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> page) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              page['image'],
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page['title'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page['desc'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 指示器
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? const Color(0xFFFF8A80)
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // 按钮
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < _pages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // 进入主应用
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A80),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                _currentPage < _pages.length - 1 ? '下一步' : '开始使用',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (_currentPage < _pages.length - 1) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Text(
                '跳过',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
