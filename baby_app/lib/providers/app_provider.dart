import 'package:flutter/material.dart';
import '../models/baby.dart';
import '../models/record.dart';
import '../services/database_service.dart';

class AppProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  
  Baby? _currentBaby;
  List<Baby> _babies = [];
  List<Record> _todayRecords = [];
  Map<String, int> _todayStats = {};
  bool _isLoading = false;
  
  Baby? get currentBaby => _currentBaby;
  List<Baby> get babies => _babies;
  List<Record> get todayRecords => _todayRecords;
  Map<String, int> get todayStats => _todayStats;
  bool get isLoading => _isLoading;
  
  // 初始化
  Future<void> init() async {
    _setLoading(true);
    
    // 加载宝宝列表
    _babies = await _db.getBabies();
    
    // 获取当前宝宝
    _currentBaby = await _db.getActiveBaby();
    
    // 如果没有宝宝，创建一个默认的
    if (_currentBaby == null) {
      await _createDefaultBaby();
    }
    
    // 加载今日记录
    await _loadTodayRecords();
    
    _setLoading(false);
  }
  
  // 创建默认宝宝
  Future<void> _createDefaultBaby() async {
    final baby = Baby(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '小宝',
      gender: 'female',
      birthDate: DateTime(2025, 9, 4),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    await _db.insertBaby(baby);
    _babies = await _db.getBabies();
    _currentBaby = baby;
  }
  
  // 切换宝宝
  Future<void> switchBaby(String babyId) async {
    _setLoading(true);
    await _db.setActiveBaby(babyId);
    _currentBaby = _babies.firstWhere((b) => b.id == babyId);
    await _loadTodayRecords();
    _setLoading(false);
    notifyListeners();
  }
  
  // 加载今日记录
  Future<void> _loadTodayRecords() async {
    if (_currentBaby == null) return;
    
    _todayRecords = await _db.getRecordsByDate(_currentBaby!.id, DateTime.now());
    _todayStats = await _db.getTodayStats(_currentBaby!.id);
  }
  
  // 添加记录
  Future<void> addRecord(Record record) async {
    _setLoading(true);
    await _db.insertRecord(record);
    await _loadTodayRecords();
    _setLoading(false);
    notifyListeners();
  }
  
  // 刷新数据
  Future<void> refresh() async {
    _setLoading(true);
    await _loadTodayRecords();
    _setLoading(false);
    notifyListeners();
  }
  
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
