allprojects {
    repositories {
        // google()
        maven { url = uri("https://mirrors.tencent.com/nexus/repository/maven-public/") }
        mavenCentral()
        // maven { url 'https://maven.aliyun.com/repository/google' }
        // maven { url 'https://maven.aliyun.com/repository/jcenter' }
        // maven { url 'https://maven.aliyun.com/repository/public' }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
