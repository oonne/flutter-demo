# 示例

## 目录

- [示例 1：Widget 中的普通翻译](#示例-1widget-中的普通翻译)
- [示例 2：函数中多次使用](#示例-2函数中多次使用)
- [示例 3：带插值的翻译](#示例-3带插值的翻译)
- [示例 4：函数级国际化](#示例-4函数级国际化)
- [示例 5：行号范围国际化](#示例-5行号范围国际化)
- [示例 6：特定文本国际化](#示例-6特定文本国际化)

## 示例 1：Widget 中的普通翻译

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

## 示例 2：函数中多次使用

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

## 示例 3：带插值的翻译

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

## 示例 4：函数级国际化

输入命令：`lib/pages/home_page.dart#handleSubmit`

输入（Dart 文件）：

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

输出（国际化后）：

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

## 示例 5：行号范围国际化

输入命令：`lib/pages/home_page.dart#L10-L15`

输入（Dart 文件第 10-15 行）：

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

输出（国际化后）：

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

## 示例 6：特定文本国际化

输入命令：`lib/pages/home_page.dart@@操作成功`

输入（Dart 文件）：

```dart
void onSuccess() {
  showToast("操作成功");
}

void onError() {
  showToast("操作失败"); // 不会被翻译
}
```

输出（国际化后）：

```dart
void onSuccess(BuildContext context) {
  showToast(AppLocalizations.of(context)!.msg_operation_success); // 操作成功
}

void onError() {
  showToast("操作失败"); // 不会被翻译
}
```
