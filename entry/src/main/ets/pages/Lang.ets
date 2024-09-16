import { Text, Column, Button } from '@ohos/arkui';
import { navigateTo } from '@ohos/router';
import { readFile, writeFile } from '@ohos/fs';
import { join } from '@ohos/path';
import { context } from '@ohos.application';

@Component
struct Lang {
  private configPath: string = ''; // 配置文件路径
  private config: any = {};
  @State selectedLanguage: string = 'zh-cn'; // 默认语言
  @State isNextButtonEnabled: boolean = false; // 下一步按钮是否启用

  async onCreate() {
    this.configPath = join(context.getFilesDir(), 'config.json');
    await this.loadConfig();
  }

  build() {
    return (
      Column() {
        Text('请选择语言 / Select Language')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(20)
          .textAlign(TextAlign.Center)
          .fontColor('#00bbff')

        Text('简体中文（中国大陆）')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'zh-cn' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'zh-cn';
            this.enableNextButton();
          })

        Text('繁體中文（台灣）')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'zh-tw' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'zh-tw';
            this.enableNextButton();
          })

        Text('繁體中文（香港特別行政區）')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'zh-hk' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'zh-hk';
            this.enableNextButton();
          })

        Text('English (US)')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'en-us' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'en-us';
            this.enableNextButton();
          })

        Text('English (United Kingdom)')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'en-gb' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'en-gb';
            this.enableNextButton();
          })

        Text('文言（華夏）')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'lzh' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'lzh';
            this.enableNextButton();
          })

        Text('Қазақша')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'kk-kz' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'kk-kz';
            this.enableNextButton();
          })

        Text('Монгол')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'mn-mn' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'mn-mn';
            this.enableNextButton();
          })

        Text('한국어')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'ko_kr' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'ko_kr';
            this.enableNextButton();
          })

        Text('བོད་སྐད།')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'bo' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'bo';
            this.enableNextButton();
          })

        Text('ئۇيغۇر تىلى')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(10)
          .fontColor(this.selectedLanguage === 'ug' ? '#00bbff' : '#000000')
          .onClick(() => {
            this.selectedLanguage = 'ug';
            this.enableNextButton();
          })

        Button(this.selectedLanguage === 'zh-cn' ? '下一步' : 'Next')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.isNextButtonEnabled ? '#00bbff' : '#cccccc')
          .fontColor(this.isNextButtonEnabled ? '#ffffff' : '#666666')
          .margin(20)
          .onClick(async () => {
            await this.saveConfig();
            navigateTo('/pages/LicenseAgreement');
          })
      }
      .padding(20)
      .backgroundColor('#f5f5f5')
      .justifyContent(FlexAlign.Center)
      .alignItems(FlexAlign.Center)
    );
  }

  private async loadConfig() {
    try {
      const content = await readFile(this.configPath, 'utf-8');
      this.config = JSON.parse(content);
      this.selectedLanguage = this.config.language || 'zh-cn';
    } catch (e) {
      // 如果文件不存在或读取失败，则使用默认值
      this.config = {
        language: 'zh-cn',
        isLoggedIn: false
      };
      await this.saveConfig();
    }
  }

  private async saveConfig() {
    this.config.language = this.selectedLanguage;
    await writeFile(this.configPath, JSON.stringify(this.config), 'utf-8');
  }

  private enableNextButton() {
    this.isNextButtonEnabled = true;
  }
}