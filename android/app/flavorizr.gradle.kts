import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.tenantapp.tenant_app.dev"
            resValue(type = "string", name = "app_name", value = "Tenant Hub Dev")
        }
        create("stg") {
            dimension = "flavor-type"
            applicationId = "com.tenantapp.tenant_app.stg"
            resValue(type = "string", name = "app_name", value = "Tenant Hub Stg")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.tenantapp.tenant_app"
            resValue(type = "string", name = "app_name", value = "Tenant Hub")
        }
    }

    buildFeatures.resValues = true
}