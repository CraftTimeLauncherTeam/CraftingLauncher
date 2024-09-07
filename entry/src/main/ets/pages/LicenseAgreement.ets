import { observe } from '@ohos/arkui';
import { File } from '@ohos/fileio';  // 用于加载本地资源文件

@Entry
@Component
struct LicenseAgreement {
    @Prop selectedLanguage: number;  // 从上一个页面传递的语言选择
    @State licenseText: string = "";  // 存储加载的用户许可协议文本
    themeColor: string = '#00bbff';  // 主题色
    @State texts: { [key: string]: string } = {};  // 存储语言文本

    aboutToAppear() {
        // 根据用户选择的语言加载相应的用户许可协议
        this.loadLicense();
        this.loadLanguageTexts();
    }

    build() {
        Column() {
            // 页面标题
            Text(this.texts['title'] || "用户许可协议 / User License Agreement")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 20, bottom: 20 })
                .fontColor(this.themeColor)
                .textAlign(TextAlign.Center)

            // 展示许可协议的文本框
            Scrollable({
                scrollDirection: Axis.Vertical
            }) {
                Text(this.licenseText)  // 显示加载的许可协议文本
                    .fontSize(16)
                    .fontWeight(FontWeight.Normal)
                    .margin(20)
            }
            .height('70%')  // 文本框占页面的 70% 高度
            .borderRadius(10)
            .backgroundColor("#f0f0f0")
            .padding(10)

            // “我已阅读并同意用户许可协议”按钮
            Button(this.texts['agreeButton'] || "我已阅读并同意用户许可协议")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.themeColor)
                .fontColor("#ffffff")
                .margin({ top: 20 })
                .onClick(() => {
                    this.navigateToLoginPage();  // 跳转到下一步
                })
        }
        .padding(20)
        .backgroundColor("#f5f5f5")
        .justifyContent(FlexAlign.Center)
        .alignItems(FlexAlign.Center)
    }

    // 根据用户选择的语言加载对应的许可协议
    loadLicense() {
        let licensePath: string;
        if (this.selectedLanguage == 1) {
            // 简体中文许可协议
            licensePath = "resources/licenses/license_zh_cn.txt";
        } else if (this.selectedLanguage == 2) {
            // 美式英语许可协议
            licensePath = "resources/licenses/license_en_us.txt";
        } else {
            // 默认加载美式英语
            licensePath = "resources/licenses/license_en_us.txt";
        }

        // 加载许可协议文本
        File.readText(licensePath).then((text) => {
            this.licenseText = text;  // 更新文本框内容
        }).catch((error) => {
            console.error("加载许可协议失败: " + error);
        });
    }

    // 根据用户选择的语言加载对应的文本内容
    loadLanguageTexts() {
        let textPath: string;
        if (this.selectedLanguage == 1) {
            // 简体中文文本
            textPath = "resources/texts/texts_zh_cn.json";
        } else {
            // 美式英语文本
            textPath = "resources/texts/texts_en_us.json";
        }

        // 加载语言文本
        File.readText(textPath).then((jsonText) => {
            this.texts = JSON.parse(jsonText);  // 更新文本内容
        }).catch((error) => {
            console.error("加载语言文本失败: " + error);
        });
    }

    // 跳转到下一页面的逻辑
    navigateToNextPage() {
        console.log("用户已同意许可协议");
        // 在这里你可以处理用户同意协议的逻辑，跳转到下一步
    }
}
