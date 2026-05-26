plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.runawaystar.flutter_demo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    buildFeatures {
        buildConfig = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
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

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
