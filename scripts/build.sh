#是否递增版本号和构件号
INCREMENT_VERSION=false
#是否打包ios
PACK_IOS=false
#是否打包android
PACK_ANDROID=true


# 记录开始时间
START_TIME=$(date +%s)

# 获取当前路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"
cd ../

# 获取包名
PACKAGE_NAME=$(grep "name:" pubspec.yaml | cut -d' ' -f2)
echo "开始打包: $PACKAGE_NAME"

# 递增版本号和构件号
VERSION_LINE=$(grep "version:" pubspec.yaml)
VERSION=$(echo $VERSION_LINE | cut -d'+' -f1 | cut -d' ' -f2)
BUILD_NUMBER=$(echo $VERSION_LINE | cut -d'+' -f2)

if [ "$INCREMENT_VERSION" = true ]; then
    # 版本号递增逻辑
    IFS='.' read -r -a version_parts <<< "$VERSION"
    major=${version_parts[0]}
    minor=${version_parts[1]}
    patch=${version_parts[2]}
    # 补丁版本号+1
    new_patch=$((patch + 1))
    new_minor=$minor
    new_major=$major
    # 如果补丁版本号超过9，进位到次版本号
    if [ $new_patch -gt 9 ]; then
        new_patch=0
        new_minor=$((minor + 1))
    fi
    # 如果次版本号超过9，进位到主版本号
    if [ $new_minor -gt 9 ]; then
        new_minor=0
        new_major=$((major + 1))
    fi
    # 构建新的版本号，写入文件
    NEW_VERSION="$new_major.$new_minor.$new_patch"
    NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))
    sed -i '' "s/version: $VERSION+$BUILD_NUMBER/version: $NEW_VERSION+$NEW_BUILD_NUMBER/" pubspec.yaml
    echo "版本号: $NEW_VERSION ($NEW_BUILD_NUMBER)"
else
    NEW_VERSION=$VERSION
    NEW_BUILD_NUMBER=$BUILD_NUMBER
    echo "跳过版本号递增，当前版本号: $NEW_VERSION ($NEW_BUILD_NUMBER)"
fi

# 打包ipa
if [ "$PACK_IOS" = true ]; then
    flutter build ipa --obfuscate --split-debug-info=scripts/symbols
    # 判断 打包后的 ipa 文件是否存在
    if [ -f "build/ios/ipa/$PACKAGE_NAME.ipa" ]; then
        echo "ipa 打包成功"
        # 复制 ipa 文件到scripts/app/ 并重命名为 package_name.ipa
        cp "build/ios/ipa/$PACKAGE_NAME.ipa" "$SCRIPT_DIR/app/$PACKAGE_NAME-$NEW_VERSION.ipa"
        # 删除 打包后的 ipa 文件
        rm -f "build/ios/ipa/$PACKAGE_NAME.ipa"
    else
        echo "ipa 打包失败"
        exit 1
    fi
else
    echo "跳过 iOS 打包"
fi

# 打包 apk - 多个 flavor
if [ "$PACK_ANDROID" = true ]; then
    FLAVORS=("googleplay" "xiaomi" "oppo" "vivo" "honor")
    for FLAVOR in "${FLAVORS[@]}"; do
        echo "开始打包 $FLAVOR flavor"
        flutter build apk --flavor $FLAVOR --obfuscate --split-debug-info=scripts/symbols-$FLAVOR
        # 判断 打包后的 apk 文件是否存在
        APK_PATH="build/app/outputs/flutter-apk/app-$FLAVOR-release.apk"
        if [ -f "$APK_PATH" ]; then
            echo "apk $FLAVOR 打包成功"
            # 复制 apk 文件到 scripts/app/ 并重命名为 package_name-flavor.apk
            cp "$APK_PATH" "$SCRIPT_DIR/app/$PACKAGE_NAME-$NEW_VERSION-$FLAVOR.apk"
            # 删除 打包后的 apk 文件
            rm -f "$APK_PATH"
        else
            echo "apk $FLAVOR 打包失败"
            exit 1
        fi
    done
else
    echo "跳过 Android 打包"
fi

# 全部打包完成
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))
echo "全部打包完成"
echo "总耗时: $((TOTAL_TIME / 60))分$((TOTAL_TIME % 60))秒"