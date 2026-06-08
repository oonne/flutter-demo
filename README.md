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
* 时间日期格式化(date_format)
* 列表上拉加载和下拉刷新(easy_refresh)
* 播放声音(audioplayers)
* 数据库(drift)
* 广告(flutter_unionad)
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
* 表单示例
* 账号密码登录页面（包含pow校验）
* 定时换票

# 开发
## 安装依赖
flutter pub get

## 如果后台在本地运行，需要更新开发环境的环境变量
sh ./scripts/update_env_ip.sh

## 寻找合适的图标
本项目图标风格为[阿里巴巴国际站官方图标库](https://www.iconfont.cn/collections/detail?cid=19238)
可使用skill来搜索或创建的图标并下载:
@icon-search 找一个”飞机“的图标。

## 国际化
由于arb文件难以维护，所以使用ts文件来管理国际化语言。  
本地安装Node.js环境，然后运行 npm install -g tsx 全局安装 tsx 依赖。
每次由ts文件生成arb文件，须运行: 
tsx ./scripts/generate_arb.ts 

如果是开发中，直接使用纯中文开发，页面完成后再调用skill去做国际化处理即可: 
@i18n 拖入指定的文件或目录。

## 生成类型定义
一次性生成
dart run build_runner build --delete-conflicting-outputs
或
sh ./scripts/build_runner.sh

监听生成
dart run build_runner watch --delete-conflicting-outputs

# 打包
运行 sh scripts/build.sh 

可打包出ipa包和apk包。
Android会根据flavor生成不同的apk包。ipa需要使用 Transporter 上传。