import { Text, Column, ScrollView, CheckBox, Button } from '@ohos/arkui';
import { navigateTo } from '@ohos/router';
import { readFile } from '@ohos/fs';
import { join } from '@ohos/path';
import { context } from '@ohos.application';
import i18n from '../i18n'; // 引入i18n模块

@Component
struct LicenseAgreement {
  private configPath: string = ''; // 配置文件路径
  private config: any = {};
  @State isAgreed: boolean = false; // 用户是否同意协议
  @State agreementText: string = ''; // 协议文本

  async onCreate() {
    this.configPath = join(context.getFilesDir(), 'config.json');
    await this.loadConfig();
    this.agreementText = await this.loadAgreementText();
  }

  build() {
    return (
      Column() {
        Text(i18n.t('license_agreement_title'))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(20)
          .textAlign(TextAlign.Center)
          .fontColor('#00bbff')

        ScrollView() {
          Column() {
            Text(this.agreementText)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin(20)
              .fontColor('#000000')
          }
          .padding(20)
          .backgroundColor('#ffffff')
        }
        .height(400) // 调整高度以适应协议文本

        CheckBox(i18n.t('agree_checkbox'))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(20)
          .onChange((checked) => {
            this.isAgreed = checked;
          })

        Button(i18n.t('next_button'))
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.isAgreed ? '#00bbff' : '#cccccc')
          .fontColor(this.isAgreed ? '#ffffff' : '#666666')
          .margin(20)
          .onClick(() => {
            navigateTo('/pages/Login');
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
      this.config.language = this.config.language || 'zh-Hans';
    } catch (e) {
      // 如果文件不存在或读取失败，则使用默认值
      this.config = {
        language: 'zh-Hans',
        isLoggedIn: false
      };
      await this.saveConfig();
    }
  }

  private async loadAgreementText() {
    // 加载用户许可协议文本
    const agreement = i18n.t('agreement');
    return agreement;
  }
}