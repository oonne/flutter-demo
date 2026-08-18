# 开发规范

1. 如无说明，不要保留向后兼容，过时的直接删掉。
2. 选择能满足当前需求的最简单实现。不要预防性抽象，不要多此一举的配置层。
3. 优先翻看项目已有的依赖和utils能做什么，别上来就假设库里没有。

# Flutter 项目规范

本项目是一个 Flutter 项目，开发时遵循以下规范。

## 主题与样式引用

为页面或组件设置样式时，**必须**优先使用 `lib/theme` 中已定义的主题变量和工具函数：

- 使用 `getCurrentThemeVars(context)` 获取当前主题的尺寸变量（如 `panelMargin`、`radius` 等）
- 使用 `getCurrentThemeColorScheme(context)` 获取当前主题的颜色方案
- 使用 `isDarkMode(context)` 判断当前是否为深色模式
- 直接引用 `ThemeVars` 中的属性（如 `themeVars.contentBackground`、`themeVars.textColor` 等）

## 组件使用

需要使用 UI 组件时，**必须**优先使用 `lib/widget` 中已封装的组件：

- 表单面板：使用 `Panel` 组件配合 `PanelItem`
- 其他组件：先查阅 `lib/widget` 目录下的已有组件

## 现有样式与组件不满足需求时

如果 `lib/theme` 和 `lib/widget` 中的现有样式与组件无法满足需求：

1. **请勿直接修改** `lib/theme` 和 `lib/widget` 下的任何文件
2. 明确提示缺少的具体样式或组件（例如：缺少某种颜色变量、缺少某种类型的组件等）
3. 说明需要补充的内容

## 国际化处理

1. 新增功能、新增文案的时候，如果没有要求，默认使用中文，不做国际化处理。
2. 如果要求做国际化，调用flutter-i18n技能。