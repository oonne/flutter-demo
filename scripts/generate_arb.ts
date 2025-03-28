import * as fs from 'fs';
import { resolve } from 'path';
import langMsg from '../assets/i18n/index';
import errorCodeMsg from '../assets/i18n/modules/error-code-msg';

/* 
 * 生成语言文件
 * langName: ts文件里的语言名，如 zh_CN
 * arbName: 生成的语言文件名，如 
 */
const generateArb = (langName: string, arbName: string, name: string) => {
  // 构造文件
  let fileContent = '{\n';
  Object.keys(langMsg).forEach(key => {
    fileContent += `  "${key}": "${langMsg[key][langName]}",\n`;
    fileContent += `  "@${key}": {},\n\n`;
  });

  fileContent = fileContent.slice(0, -3);
  fileContent += '\n}';

  // 写入文件
  fs.writeFileSync(resolve(__dirname, `../assets/i18n/arb/${arbName}`), fileContent);

  console.log(`已生成arb文件: ${arbName}`);
};

generateArb('zh_CN', 'app_zh.arb', '简体中文');
generateArb('zh_TW', 'app_zh_Hant.arb', '繁体中文');
generateArb('en_US', 'app_en.arb', '英文');
generateArb('ru_RU', 'app_ru.arb', '俄文');
generateArb('fr_FR', 'app_fr.arb', '法文');
generateArb('es_ES', 'app_es.arb', '西班牙文');
generateArb('it_IT', 'app_it.arb', '意大利文' );
generateArb('pt_PT', 'app_pt.arb', '葡萄牙文');
generateArb('de_DE', 'app_de.arb', '德文');
generateArb('ja_JP', 'app_ja.arb', '日文');
generateArb('ko_KR', 'app_ko.arb', '韩文');
generateArb('vi_VN', 'app_vi.arb', '越南文');

/* 
 * 生成错误码文件
 */
const generateErrorCode = () => {
  // 构造文件内容
  let fileContent = `import 'package:flutter_demo/generated/i18n/app_localizations.dart';

/* 
 * 错误码格式化
 */
String formatErrorCode(AppLocalizations localizations, String errorCode) {
  try {
    final Map<String, String> localizedMap = {\n`;
  
  // 添加所有的错误码映射
  Object.keys(errorCodeMsg).forEach(key => {
    fileContent += `      '${key}': localizations.${key},\n`;
  });

  fileContent += `    };
    return localizedMap[errorCode] ?? '';
  } catch (e) {
    return '';
  }
}
`;

  // 写入文件
  fs.writeFileSync(resolve(__dirname, '../lib/generated/error_code.dart'), fileContent);

  console.log('已生成错误码文件: error_code.dart');
};

// 执行生成
generateErrorCode();