---
name: "i18n"
description: "Flutter/Dart 代码国际化工具，通过查找中文文本并替换为 i18n key 实现多语言支持"
---

# i18n 国际化技能

## 描述
此技能通过查找指定文件中的中文文本并替换为 i18n key 来实现 Dart/Flutter 代码国际化。

## 使用场景
- 用户要求对文件进行 i18n 或国际化处理
- 用户要求添加翻译支持或多语言支持
- 用户提到"国际化"、"多语言"、"i18n"、"翻译"等关键词
- 需要将 Dart/Flutter 文件中的中文文本转换为国际化 key

## 使用方式

```
{{file_path}}
```

## 工作流程

### 步骤 1：分析目标文件
读取指定文件，提取所有中文文本（不包括注释）。

### 步骤 2：检查现有 i18n key
对于找到的每个中文文本：
1. 在 `assets/i18n/modules/` 中搜索匹配的翻译
2. 如果找到，使用现有 key
3. 如果未找到，根据模块类别生成新 key

### 步骤 3：模块 key 规则
| 模块 | 文件 | Key 前缀 | 示例 |
|------|------|----------|------|
| basic | basic.ts | （无） | `app_name` |
| buttons | btn.ts | `btn_` | `btn_copy`、`btn_save` |
| titles | title.ts | `title_` | `title_home`、`title_setting` |
| messages | msg.ts | `msg_` | `msg_query_failed`、`msg_operation_success` |
| info | info.ts | `info_` | `info_please_input`、`info_search` |

### 步骤 4：添加新 key 到模块文件
对于模块中未找到的新 key：
1. 根据内容含义确定适当的模块
2. 从中文生成 key 名称（转换为小写、下划线格式）
3. 将条目添加到相应的模块文件中，包含所有语言翻译

**支持插值（动态参数）**：

如果翻译文本需要动态参数（如 `"你有 {count} 条新消息"`），需要在翻译对象中添加 `_params` 属性来定义参数类型：

```typescript
msg_new_messages: {
  zh_CN: "你有 {count} 条新消息",
  zh_TW: "你有 {count} 條新訊息",
  en_US: "You have {count} new messages",
  // ... 其他语言
  _params: { count: 'int' }  // 参数定义
},
```

支持的参数类型：
- `int` - 整数类型
- `double` - 浮点数类型
- `String` - 字符串类型

支持的语言：
- zh_CN（简体中文）
- zh_TW（繁体中文）
- en_US（English）
- ru_RU（Русский）
- fr_FR（Français）
- es_ES（Español）
- it_IT（Italiano）
- pt_PT（Português）
- de_DE（Deutsch）
- ja_JP（日本語）
- ko_KR（한국어）
- vi_VN（Tiếng Việt）

### 步骤 5：生成 ARB 文件
运行以下命令生成 arb 文件：
```bash
tsx ./scripts/generate_arb.ts
```

### 步骤 6：生成 Flutter AppLocalizations 类
运行以下命令重新生成 Flutter AppLocalizations 类：
```bash
flutter gen-l10n
```

### 步骤 7：替换 Dart 文件中的中文，并提供中文注释

根据使用场景选择合适的调用方式：

#### 场景 1：在 Widget 树中直接使用
在 Widget 的 build 方法、回调函数等场景中，直接使用 `AppLocalizations.of(context)!`：

```dart
// 在 build 方法中
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.title_home), // 首页
    ),
    body: ElevatedButton(
      onPressed: () {
        showTextSnackBar(
          context,
          msg: AppLocalizations.of(context)!.msg_operation_success, // 操作成功
        );
      },
      child: Text(AppLocalizations.of(context)!.btn_save), // 保存
    ),
  );
}
```

#### 场景 2：在函数中多次使用
当在一个函数中需要多次访问 i18n 时，先获取变量以避免重复调用：

```dart
void someFunction(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;
  
  print(localizations.title_home); // 首页
  print(localizations.btn_save); // 保存
  print(localizations.msg_operation_success); // 操作成功
}
```

#### 场景 3：在工具函数中作为参数
工具函数应将 `AppLocalizations` 作为参数传递：

```dart
// 函数定义
String formatErrorCode(AppLocalizations localizations, String errorCode) {
  return localizations.unknown_error; // 未知错误
}

// 函数调用
void handleError(BuildContext context, String code) {
  final localizations = AppLocalizations.of(context)!;
  final message = formatErrorCode(localizations, code);
}
```

#### 场景 4：需要判空处理
当需要处理 localizations 可能为 null 的情况：

```dart
void someFunction(BuildContext context) {
  final localizations = AppLocalizations.of(context);
  if (localizations == null) {
    return defaultMessage;
  }
  
  return localizations.msg_operation_success; // 操作成功
}
```

**Key 前缀规则**：
- 标题：使用 `title_xxx`
- 按钮：使用 `btn_xxx`
- 消息：使用 `msg_xxx`
- 信息：使用 `info_xxx`
- 基础：使用 `xxx`（无前缀）

**带参数的翻译**：

对于包含插值参数的翻译，需要传入相应的参数：
```dart
Text(AppLocalizations.of(context)!.msg_new_messages(count: 5)) // 你有 5 条新消息
```

## 示例

### 示例 1：Widget 中的普通翻译
输入（Dart 文件）：
```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      Text("首页"),
      Text("复制"),
      Text("操作成功"),
    ],
  );
}
```

输出（国际化后）：
```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      Text(AppLocalizations.of(context)!.title_home), // 首页
      Text(AppLocalizations.of(context)!.btn_copy), // 复制
      Text(AppLocalizations.of(context)!.msg_operation_success), // 操作成功
    ],
  );
}
```

对应的 `title.ts`：
```typescript
title_home: {
  zh_CN: "首页",
  zh_TW: "首頁",
  en_US: "Home",
  // ... 其他语言
},
```

### 示例 2：函数中多次使用
输入（Dart 文件）：
```dart
void showInfo(BuildContext context) {
  print("首页");
  print("复制");
  print("操作成功");
}
```

输出（国际化后）：
```dart
void showInfo(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;
  print(localizations.title_home); // 首页
  print(localizations.btn_copy); // 复制
  print(localizations.msg_operation_success); // 操作成功
}
```

### 示例 3：带插值的翻译
输入（Dart 文件）：
```dart
Text("你有 5 条新消息")
```

输出（国际化后）：
```dart
Text(AppLocalizations.of(context)!.msg_new_messages(count: 5)) // 你有 5 条新消息
```

对应的 `msg.ts`：
```typescript
msg_new_messages: {
  zh_CN: "你有 {count} 条新消息",
  zh_TW: "你有 {count} 條新訊息",
  en_US: "You have {count} new messages",
  ru_RU: "У вас {count} новых сообщений",
  fr_FR: "Vous avez {count} nouveaux messages",
  es_ES: "Tienes {count} mensajes nuevos",
  it_IT: "Hai {count} nuovi messaggi",
  pt_PT: "Você tem {count} novas mensagens",
  de_DE: "Sie haben {count} neue Nachrichten",
  ja_JP: "{count} 件の新しいメッセージがあります",
  ko_KR: "{count}개의 새 메시지가 있습니다",
  vi_VN: "Bạn có {count} tin nhắn mới",
  _params: { count: 'int' }
},
```

生成的 ARB 文件：
```json
{
  "msg_new_messages": "你有 {count} 条新消息",
  "@msg_new_messages": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

## 重要提示

1. **注释不进行国际化** - 跳过注释块中的任何文本
2. **跳过标记为"不用翻译"的文案** - 如果中文文案前一行的注释中包含"不用翻译"，则跳过该条文案的翻译
3. **key 区分大小写** - 使用 camelCase 格式
4. **修改 ts 文件后运行 generate_arb.ts** - 生成 Flutter ARB 文件
5. **生成 ARB 文件后运行 flutter gen-l10n** - 重新生成 Flutter AppLocalizations 类
6. **验证 i18n key 存在** - 在最终替换前确保所有 key 都正确定义在模块中
7. **插值参数** - 带参数的翻译需要在 `_params` 中定义参数类型，否则参数可能无法正确工作
8. **专有名词和大写的缩写词 不需要国际化** - 专有名词（如NFC、WiFi等大写的缩写词）不需要进行国际化处理
9. **替换key后，需要提供中文注释** - 为每个替换的中文文本添加中文注释，便于后续维护
10. **选择正确的调用方式** - 根据使用场景选择 `AppLocalizations.of(context)!` 或 `localizations` 变量：
   - Widget 树中单次使用：直接使用 `AppLocalizations.of(context)!`
   - 函数中多次使用：先获取 `final localizations = AppLocalizations.of(context)!`
   - 工具函数：将 `AppLocalizations` 作为参数传递
   - 需要判空：使用 `final localizations = AppLocalizations.of(context)` 并检查 null
11. **正确的 import 路径** - 必须引用项目内生成的文件，而不是 flutter_gen 包：
   - ✅ 正确：`import 'package:{{package_name}}/generated/i18n/app_localizations.dart';`
   - ❌ 错误：`import 'package:flutter_gen/gen_l10n/app_localizations.dart';`
   - `{{package_name}}` 将自动从项目的 `pubspec.yaml` 中读取 `name` 字段。