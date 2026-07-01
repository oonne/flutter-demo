---
name: "i18n"
description: "Flutter 代码国际化工具，支持文件级、函数级、行号范围和特定文本级别的中文文本查找与 i18n key 替换，实现多语言支持"
---

# i18n 国际化技能

## 描述
此技能通过查找指定范围（文件级、函数级、行号范围、特定文本）内的中文文本并替换为 i18n key 来实现 Flutter 代码国际化。

## 使用场景

**正向条件（Use when）**：
- 用户要求对文件进行 i18n 或国际化处理
- 用户要求添加翻译支持或多语言支持
- 需要将 Dart/Flutter 文件中的中文文本转换为国际化 key
- 用户要求对某个函数内的中文进行国际化处理
- 用户要求对特定行号范围内的中文进行国际化处理
- 用户要求对特定文本进行国际化处理

**负向条件（Do NOT use when）**：
- 对非 Dart/Flutter 文件进行国际化（如纯文本、JSON、XML 等）
- 翻译注释或文档中的中文文本
- 翻译专有名词或大写缩写词（如 NFC、WiFi、API 等）
- 对已标记为"不用翻译"的文案进行国际化
- 对第三方库代码或生成的代码进行国际化

## 输入输出定义

**Input**：
- filePath: string # Dart/Flutter 文件路径，支持以下定位语法：
  - `lib/pages/home_page.dart` - 全文件国际化
  - `lib/pages/home_page.dart#build` - 函数级国际化
  - `lib/pages/home_page.dart#L10-L50` - 行号范围国际化
  - `lib/pages/home_page.dart@@操作成功` - 特定文本国际化

**Output**：
- success: boolean # 是否成功执行
- modifiedFiles: string[] # 修改的文件列表
- addedKeys: string[] # 新增的 i18n key 列表
- skippedTexts: string[] # 跳过的文本列表（如专有名词、已标记为不用翻译的文案）
- errorMessage?: string # 错误信息（失败时返回）

## 使用方式

### 语法格式

```
{{file_path}}[#{{function_name}}|#L{{start}}-L{{end}}|@@{{target_text}}]
```

### 支持的范围定位

| 语法 | 说明 | 示例 |
|------|------|------|
| `{{file_path}}` | 对整个文件进行国际化 | `lib/pages/home_page.dart` |
| `{{file_path}}#{{function_name}}` | 仅对指定函数内的中文进行国际化 | `lib/pages/home_page.dart#build` |
| `{{file_path}}#L{{start}}-L{{end}}` | 仅对指定行号范围内的中文进行国际化 | `lib/pages/home_page.dart#L10-L50` |
| `{{file_path}}@@{{target_text}}` | 仅对匹配到的特定文本进行国际化 | `lib/pages/home_page.dart@@操作成功` |

> **说明**：函数名匹配支持精确匹配和模糊匹配，行号范围支持单行（如 `#L10`）和多行（如 `#L10-L50`）。

## 工作流程

### 步骤 1：分析目标文件

首先解析用户输入的路径，确定国际化操作的范围：

#### 范围解析规则

| 输入格式 | 解析结果 | 操作范围 |
|----------|----------|----------|
| `lib/pages/home_page.dart` | `filePath: "lib/pages/home_page.dart"` | 全文件 |
| `lib/pages/home_page.dart#build` | `filePath: "lib/pages/home_page.dart", scope: "function", target: "build"` | 指定函数 |
| `lib/pages/home_page.dart#L10-L50` | `filePath: "lib/pages/home_page.dart", scope: "line", start: 10, end: 50` | 指定行号范围 |
| `lib/pages/home_page.dart#L10` | `filePath: "lib/pages/home_page.dart", scope: "line", start: 10, end: 10` | 指定单行 |
| `lib/pages/home_page.dart@@操作成功` | `filePath: "lib/pages/home_page.dart", scope: "text", target: "操作成功"` | 指定文本 |

#### 提取中文文本

根据解析得到的操作范围，从目标代码中提取所有中文文本（不包括注释）：

1. **全文件范围**：扫描整个文件内容
2. **函数范围**：定位到指定函数的代码块，只提取该函数内的中文文本
   - 通过查找函数定义（如 `void functionName`、`Widget functionName`、`String functionName` 等）确定函数起始位置
   - 通过大括号 `{}` 匹配确定函数结束位置
3. **行号范围**：只提取指定行号范围内的中文文本
4. **文本范围**：精确匹配指定的中文文本

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

根据步骤1解析的操作范围，在限定范围内进行替换：

#### 范围替换规则

| 操作范围 | 替换方式 |
|----------|----------|
| 全文件 | 在整个文件中查找并替换匹配的中文文本 |
| 指定函数 | 只在指定函数的代码块内进行替换，不影响函数外的代码 |
| 指定行号范围 | 只在指定行号范围内进行替换 |
| 指定文本 | 精确匹配并替换指定的中文文本，支持全局替换和首次匹配替换 |

#### 选择合适的调用方式

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

**处理缺少 BuildContext 的函数**：

当目标函数不包含 `BuildContext` 参数但需要访问 i18n 时，需要按照以下策略处理：

1. **优先选择已有 context 的函数**：如果目标函数所在类中有其他包含 `context` 的函数（如 `build`、`initState`、回调函数等），优先在这些函数中进行国际化
2. **添加 context 参数**：如果必须在当前函数中进行国际化，需要：
   - 为函数添加 `BuildContext context` 参数
   - 更新所有调用该函数的位置，传入 `context`
3. **级联传播**：如果调用者也没有 `context`，需要继续向上传播 `context` 参数，直到找到有 `context` 的调用点
4. **工具函数模式**：对于无法获取 `context` 的纯工具函数，应将 `AppLocalizations` 作为参数传递（见场景3）
5. **警告提示**：如果级联传播过于侵入性（影响大量文件或代码结构），应向用户发出警告，建议考虑其他方案

> **注意**：在函数级和文本级国际化中，必须确保目标代码能够访问到 `BuildContext`。如果无法安全地添加或传播 `context`，应跳过该文本的国际化并提示用户。

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

### 示例 4：函数级国际化

**输入命令**：
```
lib/pages/home_page.dart#handleSubmit
```

**输入（Dart 文件）**：
```dart
class HomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("首页"), // 不会被翻译
    );
  }

  void handleSubmit() {
    print("提交成功");
    print("请重试");
  }
}
```

**输出（国际化后）**：
```dart
class HomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("首页"), // 不会被翻译
    );
  }

  void handleSubmit(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    print(localizations.msg_submit_success); // 提交成功
    print(localizations.msg_please_retry); // 请重试
  }
}
```

### 示例 5：行号范围国际化

**输入命令**：
```
lib/pages/home_page.dart#L10-L15
```

**输入（Dart 文件，第 10-15 行）**：
```dart
// 第 10 行
Text("保存"),
// 第 11 行
Text("取消"),
// 第 12 行
Text("删除"),
// 第 13 行
// 第 14 行
Text("更多"), // 不会被翻译（在范围外）
```

**输出（国际化后）**：
```dart
// 第 10 行
Text(AppLocalizations.of(context)!.btn_save), // 保存
// 第 11 行
Text(AppLocalizations.of(context)!.btn_cancel), // 取消
// 第 12 行
Text(AppLocalizations.of(context)!.btn_delete), // 删除
// 第 13 行
// 第 14 行
Text("更多"), // 不会被翻译（在范围外）
```

### 示例 6：特定文本国际化

**输入命令**：
```
lib/pages/home_page.dart@@操作成功
```

**输入（Dart 文件）**：
```dart
void onSuccess() {
  showToast("操作成功");
}

void onError() {
  showToast("操作失败"); // 不会被翻译
}
```

**输出（国际化后）**：
```dart
void onSuccess(BuildContext context) {
  showToast(AppLocalizations.of(context)!.msg_operation_success); // 操作成功
}

void onError() {
  showToast("操作失败"); // 不会被翻译
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
12. **范围定位优先级** - 当输入同时包含多个定位语法时，按以下优先级处理：文本定位 > 行号范围 > 函数定位 > 全文件
13. **函数名匹配** - 函数名匹配支持精确匹配和模糊匹配，优先使用精确匹配；如果未找到精确匹配的函数名，则尝试模糊匹配
14. **行号范围边界** - 行号范围包含起始行和结束行；单行定位使用 `#L10` 格式
15. **文本精确匹配** - 文本定位使用 `@@` 语法，进行精确匹配；如果文件中存在多个相同文本，默认只替换首次匹配；如需全局替换，请使用全文件范围并配合其他方式筛选

## 失败策略

当遇到以下情况时，应按指定策略处理：

| 失败场景 | 处理策略 |
|----------|----------|
| 文件不存在 | 返回错误信息：`ERROR: File not found: {filePath}` |
| 文件不是 Dart/Flutter 文件 | 返回错误信息：`ERROR: Not a Dart/Flutter file: {filePath}` |
| 指定函数不存在 | 返回错误信息：`ERROR: Function not found: {functionName}`，并列出文件中所有可用函数名 |
| 指定行号范围无效（超过文件行数） | 自动调整为有效范围，从第 1 行到文件末尾 |
| 指定文本未找到 | 返回错误信息：`ERROR: Text not found: {targetText}` |
| 目标函数无法获取 BuildContext | 返回警告信息：`WARNING: Cannot access BuildContext in function {functionName}. Skipping i18n transformation.`，并列出受影响的文本 |
| 模块文件写入失败 | 返回错误信息：`ERROR: Failed to write to module file: {moduleFilePath}` |
| ARB 文件生成失败 | 返回错误信息：`ERROR: Failed to generate ARB files. Please run 'tsx ./scripts/generate_arb.ts' manually.` |
| Flutter gen-l10n 执行失败 | 返回错误信息：`ERROR: Failed to run 'flutter gen-l10n'. Please run it manually.` |

## 工作流检查清单

在执行国际化任务前，复制以下清单，并在每一步完成后显式标记状态：

- [ ] Step 1：解析输入路径，确定操作范围（全文件/函数/行号/文本）
- [ ] Step 2：验证目标文件存在且为 Dart/Flutter 文件
- [ ] Step 3：提取目标范围内的中文文本（排除注释、专有名词、已标记为不用翻译的文案）
- [ ] Step 4：检查现有 i18n key，复用已有 key，生成新 key
- [ ] Step 5：将新 key 添加到相应的模块文件（basic/btn/title/msg/info）
- [ ] Step 6：运行 `tsx ./scripts/generate_arb.ts` 生成 ARB 文件
- [ ] Step 7：运行 `flutter gen-l10n` 生成 AppLocalizations 类
- [ ] Step 8：替换 Dart 文件中的中文文本为 i18n key 调用
- [ ] Step 9：验证替换后的代码无语法错误
- [ ] Step 10：输出修改结果报告（modifiedFiles、addedKeys、skippedTexts）

**反馈闭环**：
- 若 Step 2 失败，停止执行并返回错误信息
- 若 Step 5 失败，停止执行并返回错误信息
- 若 Step 6 或 Step 7 失败，继续完成代码替换，但返回警告信息，提示用户手动执行生成命令
- 若 Step 9 发现语法错误，回滚替换并返回错误信息