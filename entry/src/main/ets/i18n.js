import { getI18n } from '@ohos/i18n';

const i18n = getI18n();

export default {
  t(key, options) {
    return i18n.t(key, options);
  }
};