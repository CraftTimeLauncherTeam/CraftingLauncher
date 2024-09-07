import { observe } from '@ohos/arkui';

@Entry
@Component
struct LoginPage {
    @State themeColor: string = '#00bbff';  // 主题色

    build() {
        Column() {
            // 页面标题
            Text("登录 / Login")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 20, bottom: 20 })
                .fontColor(this.themeColor)
                .textAlign(TextAlign.Center)

            // Microsoft账户登录按钮
            Button("Microsoft账户登录 / Microsoft Account Login")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.themeColor)
                .fontColor("#ffffff")
                .margin({ top: 20 })
                .onClick(() => {
                    this.navigateToMicrosoftLogin();  // 跳转到Microsoft账户登录
                })

            // 离线登录按钮
            Button("离线登录 / Offline Login")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.themeColor)
                .fontColor("#ffffff")
                .margin({ top: 20 })
                .onClick(() => {
                    this.navigateToOfflineLogin();  // 跳转到离线登录
                })
        }
        .padding(20)
        .backgroundColor("#f5f5f5")
        .justifyContent(FlexAlign.Center)
        .alignItems(FlexAlign.Center)
    }

    navigateToMicrosoftLogin() {
        console.log("跳转到 Microsoft 账户登录");
        // 实现跳转到 Microsoft 账户登录页面
    }

    navigateToOfflineLogin() {
        console.log("跳转到离线登录");
        // 实现跳转到离线登录页面
    }
}
