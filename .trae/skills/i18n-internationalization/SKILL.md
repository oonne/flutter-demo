---
name: "i18n-internationalization"
description: "Internationalizes Flutter/Dart code by finding Chinese text and replacing with i18n keys. Invoke when user asks to i18n, internationalize, or add translation support to a file."
---

# i18n Internationalization Skill

This skill internationalizes Dart/Flutter code by finding Chinese text in specified files and replacing them with i18n keys.

## Usage

```
{{file_path}}
```

## Workflow

### Step 1: Analyze Target File
Read the specified file and extract all Chinese text (excluding comments).

### Step 2: Check Existing i18n Keys
For each Chinese text found:
1. Search in `/Users/jay/Code/flutter-demo/assets/i18n/modules/` for matching translations
2. If found, use the existing key
3. If not found, generate a new key based on module category

### Step 3: Module Key Rules
| Module | File | Key Prefix | Example |
|--------|------|------------|---------|
| basic | basic.ts | (none) | `app_name` |
| buttons | btn.ts | `btn_` | `btn_copy`, `btn_save` |
| titles | title.ts | `title_` | `title_home`, `title_setting` |
| messages | msg.ts | `msg_` | `msg_query_failed`, `msg_operation_success` |
| info | info.ts | `info_` | `info_please_input`, `info_search` |

### Step 4: Add New Keys to Module Files
For new keys not found in existing modules:
1. Determine appropriate module based on content meaning
2. Generate key name from Chinese (convert to lowercase, underscore format)
3. Add entry to corresponding module file with all language translations

Supported languages:
- zh_CN (简体中文)
- zh_TW (繁体中文)
- en_US (English)
- ru_RU (Русский)
- fr_FR (Français)
- es_ES (Español)
- it_IT (Italiano)
- pt_PT (Português)
- de_DE (Deutsch)
- ja_JP (日本語)
- ko_KR (한국어)
- vi_VN (Tiếng Việt)

### Step 5: Generate ARB Files
Run the following command to generate arb files:
```bash
tsx ./scripts/generate_arb.ts
```

### Step 6: Generate Flutter AppLocalizations Class
Run the following command to regenerate the Flutter AppLocalizations class:
```bash
flutter gen-l10n
```

### Step 7: Replace Chinese in Dart Files
Replace all Chinese text in the target file with i18n keys using the format:
- For titles: `localizations.title_xxx`
- For buttons: `localizations.btn_xxx`
- For messages: `localizations.msg_xxx`
- For info: `localizations.info_xxx`
- For basic: `localizations.xxx`

## Example

Input (Dart file):
```dart
Text("首页")
Text("复制")
Text("操作成功")
```

Output (after i18n):
```dart
Text(localizations.title_home)
Text(localizations.btn_copy)
Text(localizations.msg_operation_success)
```

And in `title.ts`:
```typescript
title_home: {
  zh_CN: "首页",
  zh_TW: "首頁",
  en_US: "Home",
  // ... other languages
},
```

## Important Notes

1. **Comments are NOT internationalized** - Skip any text within comment blocks
2. **Keys are case-sensitive** - Use camelCase for keys
3. **Run generate_arb.ts after modifying ts files** - This generates the Flutter ARB files
4. **Run flutter gen-l10n after generating ARB files** - This regenerates the Flutter AppLocalizations class
5. **Verify i18n keys exist** - Ensure all keys are properly defined in modules before final replacement
