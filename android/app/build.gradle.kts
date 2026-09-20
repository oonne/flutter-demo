import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// 读取 android/key.properties
val keystoreProperties = Properties().apply {
    val keystorePropertiesFile = rootProject.file("key.properties")
    if (keystorePropertiesFile.exists()) {
        load(FileInputStream(keystorePropertiesFile))
    }
}


android {
    namespace = "com.runawaystar.flutter_demo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    buildFeatures {
        buildConfig = true
        resValues = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    flavorDimensions += "store"
    productFlavors {
        create("googleplay") {
            dimension = "store"
            applicationIdSuffix = ".googleplay"
            resValue("string", "app_name", "Flutter Demo")
            buildConfigField("String", "FLAVOR", "\"googleplay\"")
        }
        create("xiaomi") {
            dimension = "store"
            applicationIdSuffix = ".xiaomi"
            resValue("string", "app_name", "Flutter Demo")
            buildConfigField("String", "FLAVOR", "\"xiaomi\"")
        }
        create("oppo") {
            dimension = "store"
            applicationIdSuffix = ".oppo"
            resValue("string", "app_name", "Flutter Demo")
            buildConfigField("String", "FLAVOR", "\"oppo\"")
        }
        create("vivo") {
            dimension = "store"
            applicationIdSuffix = ".vivo"
            resValue("string", "app_name", "Flutter Demo")
            buildConfigField("String", "FLAVOR", "\"vivo\"")
        }
        create("honor") {
            dimension = "store"
            applicationIdSuffix = ".honor"
            resValue("string", "app_name", "Flutter Demo")
            buildConfigField("String", "FLAVOR", "\"honor\"")
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.runawaystar.flutter_demo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            // 未配置 key.properties 时回退到 debug 签名，保证 `flutter run --release` 仍可用
            signingConfig = if (keystoreProperties.isEmpty) {
                signingConfigs.getByName("debug")
            } else {
                signingConfigs.getByName("release")
            }
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_11
    }
}

flutter {
    source = "../.."
}
