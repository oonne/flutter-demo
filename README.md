# flutter-demo
flutter 基础项目

## 功能
* iOS & Android 打包脚本
* 环境变量(flutter_dotenv)
* 日志(logger)
* 全局数据(provider)
* 路由(go_router)
* 事件总线(event_bus)
* 自定义svg图标(flutter_svg)
* 自定义字体
* 国际化
* MVVM页面示例
* 深浅主题切换
* 全局样式
* 按钮
* 底导航
* AppBar
* 底部弹框 BottomSheet
* 提示 SnackBar
* 时间日期选择器(board_datetime_picker)

* 模态弹框组件
* 网络请求
* 二维码扫描

# 打包
运行 sh scripts/build.sh 

可打包出ipa包和apk包。
ipa需要使用 Transporter 上传。

# 开发
## 国际化
由于arb文件难以维护，所以使用ts文件来管理国际化语言。  
本地安装Node.js环境，然后运行 npm install -g tsx 全局安装 tsx 依赖。
每次由ts文件生成arb文件，须运行: 
tsx ./scripts/generate_arb.ts 