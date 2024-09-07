import { observe } from '@ohos/arkui';

@Entry
@Component
struct MainApp {
    @State selectedLanguage: number = 0;  // 用于存储用户选择的语言
    themeColor: string = '#00bbff';  // 启动器的主题色

    build() {
        // 根据不同的页面状态渲染不同的页面
        if (this.selectedLanguage == 0) {
            // 当前为语言选择页面
            LanguageSelection({
                onLanguageSelected: (language) => {
                    this.selectedLanguage = language;  // 保存选择的语言
                    this.navigateToLicenseAgreement();  // 跳转到用户许可协议页面
                }
            })
        } else {
            // 用户已经选择语言，跳转到用户许可协议页面
            LicenseAgreement({ selectedLanguage: this.selectedLanguage })  // 传递选择的语言
        }
    }

    // 跳转到用户许可协议页面的逻辑
    navigateToLicenseAgreement() {
        console.log("Language selected:", this.selectedLanguage == 1 ? "简体中文" : "English (US)");
    }
}

// 语言选择组件
@Component
struct LanguageSelection {
    @Prop onLanguageSelected: (language: number) => void;

    @State selectedLanguage: number = 0;  // 语言选择状态
    themeColor: string = '#00bbff';  // 主题色

    build() {
        Column() {
            // 标题部分
            Text("请选择语言 / Select Language")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin(20)
                .textAlign(TextAlign.Center)
                .fontColor(this.themeColor)

            // 简体中文选项
            Button("简体中文")
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(this.selectedLanguage == 1 ? this.themeColor : "#ffffff")
                .fontColor(this.selectedLanguage == 1 ? "#ffffff" : "#000000")
                .margin(20)
                .onClick(() => {
                    this.selectedLanguage = 1;
                })

            // 美式英语选项
            Button("English (US)")
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(this.selectedLanguage == 2 ? this.themeColor : "#ffffff")
                .fontColor(this.selectedLanguage == 2 ? "#ffffff" : "#000000")
                .margin(20)
                .onClick(() => {
                    this.selectedLanguage = 2;
                })

            // “下一步”按钮
            if (this.selectedLanguage != 0) {
                Button("下一步 / Next")
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .backgroundColor(this.themeColor)
                    .fontColor("#ffffff")
                    .margin({ top: 50 })
                    .onClick(() => {
                        // 调用父组件的回调函数，通知选择的语言
                        this.onLanguageSelected(this.selectedLanguage);
                    })
            }
        }
        .padding(20)
        .backgroundColor("#f5f5f5")  // 页面背景色
        .justifyContent(FlexAlign.Center)
        .alignItems(FlexAlign.Center)
    }
}
接下来就是要用户登录账号了。登陆账号有两个选项，一个是Microsoft账户登录，一个是离线登录
还有，从LicenseAgreement.ets开始，你需要实时更新语言文件了。当然，为了减轻你的输出负担，每次的语言文件只需要给出“添加……”或“修改……”即可。LicenseAgreement.ets也要开始采用语言文件了，毕竟如果用户在App.ets选择了美式英语却在接下来的页面看到的全都是中文的按钮确实挺不合适的。