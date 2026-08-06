# Flutter 项目规范

本文件为仓库级规则，Codex 在项目根目录下工作时始终加载。

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
