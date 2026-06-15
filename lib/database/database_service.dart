import 'database.dart';

/// 数据库服务
///
/// 负责数据库的初始化和管理
/// 提供通用的数据库预初始化方法，与具体表无关
class DatabaseService {
  /// 单例实例
  static final DatabaseService _instance = DatabaseService._internal();
  static DatabaseService get instance => _instance;

  /// 数据库是否已初始化
  static bool _isInitialized = false;

  /// 私有构造函数
  DatabaseService._internal();

  /// 预初始化数据库
  ///
  /// 在应用启动时调用，后台异步初始化数据库连接
  /// 不阻塞UI，与具体表无关，后续新增表无需修改此处代码
  Future<void> preInitialize() async {
    if (_isInitialized) return;

    try {
      // 访问数据库实例，触发 LazyDatabase 初始化
      // 使用 instance 属性确保单例
      final _ = DemoDatabase.instance;
      _isInitialized = true;
    } catch (e) {
      // 初始化失败不影响应用启动
    }
  }

  /// 获取数据库实例
  ///
  /// 返回已初始化的数据库单例
  DemoDatabase get database => DemoDatabase.instance;

  /// 检查数据库是否已初始化
  bool get isInitialized => _isInitialized;
}
