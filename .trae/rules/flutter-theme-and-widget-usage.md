# Flutter 页面样式与组件使用规则

## 主题与样式引用

当需要为页面或组件设置样式时，**必须**优先使用 `lib/theme` 中已定义的主题变量和工具函数：

- 使用 `getCurrentThemeVars(context)` 获取当前主题的尺寸变量（如 `panelMargin`、`radius` 等）
- 使用 `getCurrentThemeColorScheme(context)` 获取当前主题的颜色方案
- 使用 `isDarkMode(context)` 判断当前是否为深色模式
- 直接引用 `ThemeVars` 中的属性（如 `themeVars.contentBackground`、`themeVars.textColor` 等）

## 组件使用

当需要使用 UI 组件时，**必须**优先使用 `lib/widget` 中已封装的组件：

- 表单面板：使用 `Panel` 组件配合 `PanelItem`
- 其他组件：先查阅 `lib/widget` 目录下的已有组件

## 不满足需求时的处理方式

如果 `lib/theme` 和 `lib/widget` 中的现有样式和组件无法满足需求：

1. **请勿直接修改** `lib/theme` 和 `lib/widget` 下的任何文件
2. 请明确提示具体缺少什么样式或组件
3. 在提示中说明需要补充的内容（如：缺少某种颜色变量、缺少某种类型的组件等）
