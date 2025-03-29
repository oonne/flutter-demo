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
* 时间日期选择器(board_datetime_picker)
* 网络请求(dio)
* 计算SHA(crypto)
* 二维码扫描(mobile_scanner)
* 本地图片选择(image_picker)
* 国际化(flutter_localizations)
* JSON序列化(json_annotation)
* 自定义字体
* 深浅主题切换
* 全局样式
* 按钮
* 底导航
* AppBar
* 模态弹框
* 底部弹框 BottomSheet
* 提示 SnackBar
* MVVM页面示例
* 账号密码登录页面（包含pow校验）
* TODO 定时换票
* TODO 列表上拉加载和下拉刷新(easy_refresh)

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

## 生成类型定义
一次性生成
dart run build_runner build --delete-conflicting-outputs

监听生成
dart run build_runner watch --delete-conflicting-outputs