---
alwaysApply: false
globs: lib/pages/**/*.dart
description: 所有页面必须遵循 MVVM 架构规范，将数据存储于 model，数据和逻辑处理存储于 view_model，样式和布局存储于 view
---

# MVVM 架构规范

## 核心原则

所有 `lib/pages/` 下的页面必须严格遵循 MVVM 架构模式，分为三个独立文件：

### 1. Model 层
- **文件命名**: `{page_name}_model.dart`
- **职责**: 仅存储数据结构
- **示例**:
  ```dart
  class PageNameModel {
    int number = 0;
    String name = '';
  }
  ```

### 2. ViewModel 层
- **文件命名**: `{page_name}_view_model.dart`
- **职责**: 
  - 持有 Model 实例
  - 包含业务逻辑处理
  - 继承 `ChangeNotifier`
  - 使用 `notifyListeners()` 通知视图更新
- **示例**:
  ```dart
  import 'package:flutter/material.dart';
  import 'page_name_model.dart';

  class PageNameViewModel extends ChangeNotifier {
    final PageNameModel model = PageNameModel();

    init(Map<String, dynamic>? extra) {
      // 初始化逻辑
      notifyListeners();
    }

    void someAction() {
      // 业务逻辑
      notifyListeners();
    }
  }
  ```

### 3. View 层
- **文件命名**: `{page_name}_view.dart`
- **职责**: 
  - 仅包含 UI 布局和样式
  - 使用 `ChangeNotifierProvider` 和 `Consumer` 绑定 ViewModel
  - 不包含业务逻辑
- **示例**:
  ```dart
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'page_name_view_model.dart';

  class PageNameView extends StatefulWidget {
    const PageNameView({super.key});

    @override
    State<PageNameView> createState() => _PageNameViewState();
  }

  class _PageNameViewState extends State<PageNameView> {
    late final PageNameViewModel viewModel;

    @override
    void initState() {
      super.initState();
      viewModel = PageNameViewModel();
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.init(null);
      });
    }

    @override
    Widget build(BuildContext context) {
      return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<PageNameViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              // UI 布局
            );
          },
        ),
      );
    }
  }
  ```

## 目录结构要求

```
lib/pages/
└── {module_name}/
    ├── {page_name}_model.dart
    ├── {page_name}_view_model.dart
    └── {page_name}_view.dart
```

## 参考示例

参考项目中的 `lib/pages/demo/mvvm/` 目录下的实现作为标准模板。
