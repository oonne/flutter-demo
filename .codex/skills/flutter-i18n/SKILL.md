---
name: flutter-i18n
description: "将 Dart/Flutter 代码中的中文文本替换为 i18n key，接入项目多语言体系（assets/i18n 模块、ARB 生成与 flutter gen-l10n）。当用户要求对 Flutter 项目做国际化、多语言或翻译支持，或按文件、函数、行号范围、特定文本定位并转换中文文案时使用；不用于非 Dart 文件、注释、文档或第三方代码的翻译。"
---

# Flutter 国际化

## 概述

将目标 Dart 文件限定范围内的中文文本提取为 i18n key：在 `assets/i18n/modules/` 中复用或新增翻译条目，生成 ARB 文件并重新生成 `AppLocalizations`，最后把中文替换为 key 调用并保留中文注释。

## 项目路径速查

本仓库为 Flutter 应用（`pubspec.yaml` 中包名为 `flutter_demo`），以下为国际化相关路径，所有命令在仓库根目录执行：

| 用途 | 路径 |
| --- | --- |
| 翻译模块文件 | `assets/i18n/modules/basic.ts`、`btn.ts`、`title.ts`、`msg.ts`、`info.ts` |
| ARB 输出目录（`l10n.yaml` 的 `arb-dir`） | `assets/i18n/arb/` |
| 生成的本地化类 | `lib/generated/i18n/app_localizations.dart` |
| ARB 生成脚本 | `scripts/generate_arb.ts` |
| 包名（`pubspec.yaml` 的 `name`） | `flutter_demo` |

## 输入与定位范围

输入格式：`{{文件路径}}[#{{函数名}} | #L{{起始}}-L{{结束}} | @@{{目标文本}}]`

| 语法 | 说明 | 示例 |
| --- | --- | --- |
| `{{文件路径}}` | 国际化整个文件 | `lib/pages/home_page.dart` |
| `{{文件路径}}#{{函数名}}` | 仅国际化指定函数 | `lib/pages/home_page.dart#build` |
| `{{文件路径}}#L{{起始}}-L{{结束}}` | 仅国际化行号范围（支持单行 `#L10`） | `lib/pages/home_page.dart#L10-L50` |
| `{{文件路径}}@@{{目标文本}}` | 仅国际化匹配到的特定文本 | `lib/pages/home_page.dart@@操作成功` |

多种定位同时出现时按以下优先级处理：文本定位 > 行号范围 > 函数定位 > 全文件。

## 工作流程

### 步骤 1：解析范围并提取中文

1. 解析输入，确定操作范围。
2. 验证文件存在且为 Dart 文件（`.dart`）。
3. 在范围内提取中文文本，跳过：
   - 注释中的文本
   - 专有名词与全大写缩写（如 NFC、WiFi、API）
   - 前一行注释含“不用翻译”的文案
   - 第三方库或生成代码中的文本

### 步骤 2：复用或生成 key

对每个中文文本：

1. 在 `assets/i18n/modules/` 中搜索已有翻译，找到则复用对应 key。
2. 未找到时，根据内容含义确定模块并生成新 key（模块表见下文）。
3. 将条目写入对应模块文件，补齐全部语言翻译；需要插值参数时添加 `_params`。

### 步骤 3：生成 ARB 与 AppLocalizations

按顺序运行：

```bash
tsx ./scripts/generate_arb.ts
flutter gen-l10n
```

确认 `lib/generated/i18n/app_localizations.dart` 已更新后再替换代码。

### 步骤 4：替换中文并添加中文注释

在限定范围内把中文替换为 i18n 调用，并在每个替换处保留中文注释。

## 模块 key 规则

| 模块 | 文件 | Key 前缀 | 示例 |
| --- | --- | --- | --- |
| basic | `basic.ts` | 无 | `app_name` |
| buttons | `btn.ts` | `btn_` | `btn_copy`、`btn_save` |
| titles | `title.ts` | `title_` | `title_home`、`title_setting` |
| messages | `msg.ts` | `msg_` | `msg_query_failed`、`msg_operation_success` |
| info | `info.ts` | `info_` | `info_please_input`、`info_search` |

Key 使用 camelCase。带插值参数的条目需定义 `_params`（支持 `int`、`double`、`String`）：

```typescript
msg_new_messages: {
  zh_CN: "你有 {count} 条新消息",
  // ... 其他语言
  _params: { count: 'int' }
},
```

## 替换调用方式

### Widget 树中单次使用

```dart
Text(AppLocalizations.of(context)!.btn_save), // 保存
```

### 函数中多次使用

```dart
final localizations = AppLocalizations.of(context)!;
print(localizations.title_home); // 首页
```

### 工具函数作为参数

```dart
String formatErrorCode(AppLocalizations localizations, String errorCode) {
  return localizations.unknown_error; // 未知错误
}
```

### 需要判空

```dart
final localizations = AppLocalizations.of(context);
if (localizations == null) return defaultMessage;
return localizations.msg_operation_success; // 操作成功
```

### 带参数的翻译

```dart
Text(AppLocalizations.of(context)!.msg_new_messages(count: 5)) // 你有 5 条新消息
```

## BuildContext 处理

目标函数缺少 `BuildContext` 时：

1. 优先选择同一类中已有 `context` 的函数（如 `build`、`initState`、回调函数）进行国际化。
2. 必须在当前函数内处理时，为函数添加 `BuildContext context` 参数，并更新所有调用点。
3. 调用者也没有 `context` 时继续向上传播参数，直到找到有 `context` 的调用点。
4. 无法获取 `context` 的纯工具函数，改为把 `AppLocalizations` 作为参数传入。
5. 级联传播影响过大（涉及大量文件或代码结构）时，跳过该文本并向用户提示，不要强行改造。

## import 路径

引用项目内生成的文件，而不是 flutter_gen 包。本仓库中直接使用包名 `flutter_demo`：

```dart
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
```

## 失败策略

| 失败场景 | 处理 |
| --- | --- |
| 文件不存在 | 返回 `ERROR: File not found: {filePath}` |
| 非 Dart 文件 | 返回 `ERROR: Not a Dart/Flutter file: {filePath}` |
| 指定函数不存在 | 返回 `ERROR: Function not found: {functionName}` 并列出文件内可用函数 |
| 行号范围超界 | 自动调整为文件有效范围 |
| 指定文本未找到 | 返回 `ERROR: Text not found: {targetText}` |
| 无法获取 BuildContext | 返回警告并跳过，列出受影响文本 |
| 模块文件写入失败 | 返回 `ERROR: Failed to write to module file: {moduleFilePath}` |
| ARB 生成失败 | 返回错误，提示手动运行 `tsx ./scripts/generate_arb.ts` |
| gen-l10n 失败 | 返回错误，提示手动运行 `flutter gen-l10n` |

## 工作流检查清单

执行前复制以下清单，每完成一步显式标记状态：

- [ ] 解析输入，确定范围（全文件 / 函数 / 行号 / 文本）
- [ ] 验证目标文件存在且为 Dart 文件
- [ ] 提取范围内中文（排除注释、专有名词、“不用翻译”文案）
- [ ] 复用已有 key；无则生成新 key
- [ ] 写入模块文件（basic / btn / title / msg / info）
- [ ] 运行 `tsx ./scripts/generate_arb.ts`
- [ ] 运行 `flutter gen-l10n`
- [ ] 替换中文为 key 调用并添加中文注释
- [ ] 验证替换后代码无语法错误
- [ ] 输出结果报告（modifiedFiles / addedKeys / skippedTexts）

失败时的反馈闭环：

- 文件验证失败：停止并返回错误。
- 模块写入失败：停止并返回错误。
- ARB 或 gen-l10n 失败：继续完成代码替换，但返回警告，提示用户手动执行生成命令。
- 语法错误：回滚替换并返回错误。

## 参考

完整代码示例见 [references/examples.md](references/examples.md)。
