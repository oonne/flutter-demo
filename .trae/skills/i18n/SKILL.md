---
name: "i18n"
description: "通过查找中文文本并替换为 i18n key 来实现 Flutter/Dart 代码国际化。当用户要求对文件进行 i18n、国际化或添加翻译支持时调用此技能。"
---

# i18n 国际化技能

此技能通过查找指定文件中的中文文本并替换为 i18n key 来实现 Dart/Flutter 代码国际化。

## 使用方式

```
{{file_path}}
```

## 工作流程

### 步骤 1：分析目标文件
读取指定文件，提取所有中文文本（不包括注释）。

### 步骤 2：检查现有 i18n key
对于找到的每个中文文本：
1. 在 `/Users/jay/Code/flutter-demo/assets/i18n/modules/` 中搜索匹配的翻译
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

### 步骤 7：替换 Dart 文件中的中文
使用以下格式将目标文件中的所有中文替换为 i18n key：
- 标题：使用 `localizations.title_xxx`
- 按钮：使用 `localizations.btn_xxx`
- 消息：使用 `localizations.msg_xxx`
- 信息：使用 `localizations.info_xxx`
- 基础：使用 `localizations.xxx`

## 示例

输入（Dart 文件）：
```dart
Text("首页")
Text("复制")
Text("操作成功")
```

输出（国际化后）：
```dart
Text(localizations.title_home)
Text(localizations.btn_copy)
Text(localizations.msg_operation_success)
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

## 重要提示

1. **注释不进行国际化** - 跳过注释块中的任何文本
2. **key 区分大小写** - 使用 camelCase 格式
3. **修改 ts 文件后运行 generate_arb.ts** - 生成 Flutter ARB 文件
4. **生成 ARB 文件后运行 flutter gen-l10n** - 重新生成 Flutter AppLocalizations 类
5. **验证 i18n key 存在** - 在最终替换前确保所有 key 都正确定义在模块中
