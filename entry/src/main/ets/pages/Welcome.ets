import { Text, Column, Button, Image } from '@ohos/arkui';
import { navigateTo } from '@ohos/router';
import { readFile } from '@ohos/fs';
import { join } from '@ohos/path';
import { context } from '@ohos.application';

@Component
struct Welcome {
  private configPath: string = ''; // 配置文件路径
  private config: any = {};
  @State playerName: string = ''; // 玩家名称
  @State playerSkin: string = ''; // 玩家皮肤路径

  async onCreate() {
    this.configPath = join(context.getFilesDir(), 'config.json');
    await this.loadConfig();
  }

  build() {
    return (
      Column() {
        // 显示玩家头像
        Image(this.playerSkin)
          .width(100)
          .height(100)
          .margin(20)
          .borderRadius(50)

        Text(`欢迎，${this.playerName}！`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(20)
          .textAlign(TextAlign.Center)
          .fontColor('#00bbff')

        Button('下一步 / Next')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#00bbff')
          .fontColor('#ffffff')
          .margin(20)
          .onClick(() => {
            navigateTo('/pages/MainPage');
          })

        Button('添加新的账号 / Add New Account')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#00bbff')
          .fontColor('#ffffff')
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
      this.playerName = this.config.username || this.config.offlineProfile?.name || '';
      this.playerSkin = this.config.skinPath || this.config.offlineProfile?.skinPath || '';
    } catch (e) {
      console.error('Failed to load config file:', e);
    }
  }
}