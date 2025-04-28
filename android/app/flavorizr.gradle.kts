import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.hungvk.chatbot"
            applicationIdSuffix = ".dev"
            resValue(type = "string", name = "app_name", value = "Chatbot Dev")
        }
        create("stag") {
            dimension = "flavor-type"
            applicationId = "com.hungvk.chatbot"
            applicationIdSuffix = ".stag"
            resValue(type = "string", name = "app_name", value = "Chatbot Stag")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.hungvk.chatbot"
            resValue(type = "string", name = "app_name", value = "Chatbot")
        }
    }
}