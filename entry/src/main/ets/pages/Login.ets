import { Text, Column, Button, TextInput, Picker, Switch } from '@ohos/arkui';
import { navigateTo } from '@ohos/router';
import { readFile, writeFile } from '@ohos/fs';
import { join } from '@ohos/path';
import { context } from '@ohos.application';
import { openUrl } from '@ohos/ability';

@Component
struct Login {
  private configPath: string = ''; // 配置文件路径
  private config: any = {};
  @State selectedLoginMethod: string = 'microsoft'; // 登录方式
  @State username: string = ''; // 离线登录用户名
  @State skinPath: string = ''; // 皮肤路径
  @State armModel: string = 'slim'; // 手臂模型类型
  @State isNextButtonEnabled: boolean = false; // 下一步按钮是否启用

  async onCreate() {
    this.configPath = join(context.getFilesDir(), 'config.json');
    await this.loadConfig();
  }

  build() {
    return (
      Column() {
        Text('请选择登录方式 / Select Login Method')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(20)
          .textAlign(TextAlign.Center)
          .fontColor('#00bbff')

        Button('Microsoft Account')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.selectedLoginMethod === 'microsoft' ? '#00bbff' : '#ffffff')
          .fontColor(this.selectedLoginMethod === 'microsoft' ? '#ffffff' : '#000000')
          .margin(20)
          .onClick(() => {
            this.selectedLoginMethod = 'microsoft';
            this.enableNextButton();
          })

        Button('离线登录 / Offline Login')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.selectedLoginMethod === 'offline' ? '#00bbff' : '#ffffff')
          .fontColor(this.selectedLoginMethod === 'offline' ? '#ffffff' : '#000000')
          .margin(20)
          .onClick(() => {
            this.selectedLoginMethod = 'offline';
            this.enableNextButton();
          })

        // 离线登录输入框
        TextInput('请输入用户名 / Enter Username')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(20)
          .onChange((value) => {
            this.username = value;
            this.enableNextButton();
          })

        // 皮肤选择
        Button('选择皮肤 / Choose Skin')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#00bbff')
          .fontColor('#ffffff')
          .margin(20)
          .onClick(() => {
            // TODO: 实现皮肤选择逻辑
            this.skinPath = '/path/to/skin.png';
            this.enableNextButton();
          })

        // 手臂模型选择
        Text('请选择手臂模型 / Select Arm Model')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(20)

        Picker(['细手臂 / Slim', '粗手臂 / Normal'])
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(20)
          .onChange((index) => {
            this.armModel = index === 0 ? 'slim' : 'normal';
            this.enableNextButton();
          })

        Button(this.selectedLoginMethod === 'zh-cn' ? '下一步' : 'Next')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.isNextButtonEnabled ? '#00bbff' : '#cccccc')
          .fontColor(this.isNextButtonEnabled ? '#ffffff' : '#666666')
          .margin(20)
          .onClick(async () => {
            await this.handleLogin();
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
    this.config.loginMethod = this.selectedLoginMethod;
    this.config.username = this.username;
    this.config.skinPath = this.skinPath;
    this.config.armModel = this.armModel;
    await writeFile(this.configPath, JSON.stringify(this.config), 'utf-8');
  }

  private enableNextButton() {
    if ((this.selectedLoginMethod === 'microsoft') ||
        (this.selectedLoginMethod === 'offline' && this.username !== '' && this.skinPath !== '')) {
      this.isNextButtonEnabled = true;
    } else {
      this.isNextButtonEnabled = false;
    }
  }

  private async handleLogin() {
    if (this.selectedLoginMethod === 'microsoft') {
      // 打开微软登录页面
      const loginUrl = 'https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize?prompt=login&client_id=00000000402b5328&response_type=code&scope=service%3A%3Auser.auth.xboxlive.com%3A%3AMBI_SSL&redirect_uri=https%3A%2F%2Flogin.live.com%2Foauth20_desktop.srf';
      await openUrl(loginUrl);
      // 待用户完成登录后，从重定向的URL中提取Token
      // TODO: 实现获取Token的逻辑
      console.log('Microsoft login not fully implemented yet.');
      await this.saveConfig();
      navigateTo('/pages/Welcome');
    } else if (this.selectedLoginMethod === 'offline') {
      // 生成UUID
      const uuid = this.generateUuid();
      // 设置离线登录信息
      this.config.offlineProfile = {
        name: this.username,
        uuid: uuid,
        skinPath: this.skinPath,
        armModel: this.armModel
      };
      await this.saveConfig();
      navigateTo('/pages/Welcome');
    }
  }

  private generateUuid(): string {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      const r = Math.random() * 16 | 0;
      const v = c === 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }
}