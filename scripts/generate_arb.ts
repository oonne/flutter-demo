import * as fs from 'fs';
import { resolve } from 'path';
import langMsg from '../assets/i18n/index';

/* 
 * 生成语言文件
 * langName: ts文件里的语言名，如 zh_CN
 * arbName: 生成的语言文件名，如 
 */
const generateArb = (langName: string, arbName: string) => {
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
};

generateArb('zh_CN', 'app_zh.arb');
generateArb('zh_TW', 'app_zh_Hant.arb');
generateArb('en_US', 'app_en.arb');
generateArb('ru_RU', 'app_ru.arb');
generateArb('fr_FR', 'app_fr.arb');
generateArb('es_ES', 'app_es.arb');
generateArb('it_IT', 'app_it.arb');
generateArb('pt_PT', 'app_pt.arb');
generateArb('de_DE', 'app_de.arb');
generateArb('ja_JP', 'app_ja.arb');
generateArb('ko_KR', 'app_ko.arb');
generateArb('vi_VN', 'app_vi.arb');

console.log('已生成arb文件');