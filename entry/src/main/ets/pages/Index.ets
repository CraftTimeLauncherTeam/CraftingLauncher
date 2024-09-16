import { Ability } from '@ohos.application.Ability';
import { window } from '@ohos.window';
import { readFile, writeFile } from '@ohos/fs';
import { join } from '@ohos/path';
import { context } from '@ohos.application';
import { navigateTo } from '@ohos/router';

export default class MainAbility extends Ability {
  private configPath: string = ''; // 配置文件路径
  private config: any = {};

  async onCreate(want, launchParam) {
    console.log('MainAbility onCreate');
    this.configPath = join(context.getFilesDir(), 'config.json');
    await this.initializeConfig();
  }

  onDestroy() {
    console.log('MainAbility onDestroy');
  }

  onWindowStageCreate(windowStage) {
    // Main window stage created, set the main page for this ability
    if (!this.config.isLoggedIn) {
      // 如果用户未登录，则导航到语言选择页面
      navigateTo('/pages/Lang');
    } else {
      // 如果用户已登录，则导航到主页面
      windowStage.loadContent('pages/MainPage', (err, data) => {
        if (err.code) {
          console.error('Failed to load the content. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in loading the content. Data: ' + JSON.stringify(data));
      });
    }
  }

  private async initializeConfig() {
    try {
      const content = await readFile(this.configPath, 'utf-8');
      this.config = JSON.parse(content);
    } catch (e) {
      // 如果文件不存在或读取失败，则创建并使用默认值
      this.config = {
        language: 'zh-cn',
        isLoggedIn: false
      };
      await this.saveConfig();
    }
  }

  private async saveConfig() {
    await writeFile(this.configPath, JSON.stringify(this.config), 'utf-8');
  }

  onWindowStageDestroy() {
    // Main window stage destroyed
  }

  onForeground() {
    // Ability has moved to the foreground
  }

  onBackground() {
    // Ability has moved to the background
  }
}