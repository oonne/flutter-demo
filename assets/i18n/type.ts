/* 参数类型定义 */
export interface IParams {
  [key: string]: 'int' | 'double' | 'String';
}

/* 语言类型 */
export interface ILangMsg {
  // 中文
  zh_CN: string;
  zh_TW: string;
  // 英语
  en_US: string;
  // 俄语
  ru_RU: string;
  // 法语
  fr_FR: string;
  // 西班牙语
  es_ES: string;
  // 意大利语
  it_IT: string;
  // 葡萄牙语
  pt_PT: string;
  // 德语
  de_DE: string;
  // 日语
  ja_JP: string;
  // 韩语
  ko_KR: string;
  // 越南语
  vi_VN: string;
  // 可选的参数定义（用于插值）
  _params?: IParams;
}

export interface ILangMsgs {
  [key: string | number]: ILangMsg;
}