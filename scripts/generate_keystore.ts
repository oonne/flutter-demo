import * as fs from 'fs';
import { resolve } from 'path';
import { execSync } from 'child_process';
import { randomBytes } from 'crypto';

/*
 * 生成 release 签名所需的 keystore 与 key.properties
 * 运行: tsx ./scripts/generate_release_key.ts
 *
 * 产物:
 *   android/release-key.jks   keystore 文件
 *   android/key.properties    供 build.gradle.kts 读取的签名配置
 *
 * 若 release-key.jks 已存在则直接覆盖。
 */

const KEYSTORE_PATH = resolve(__dirname, '../android/release-key.jks');
const KEY_PROPERTIES_PATH = resolve(__dirname, '../android/key.properties');

const ALIAS = 'release-key';
const VALIDITY_DAYS = 36500; // 100 年
const DNAME = 'CN=PicoNFC, OU=Dev, O=RunawayStar, L=Shenzhen, ST=Guangdong, C=CN';

const generatePassword = (length = 32): string => {
  // hex 编码每字节 2 字符，截断到目标长度
  return randomBytes(length).toString('hex').slice(0, length);
};

const main = (): void => {
  // keytool -genkeypair 遇到已有同名 alias 会报错，先删除旧 keystore 以直接覆盖
  if (fs.existsSync(KEYSTORE_PATH)) {
    fs.rmSync(KEYSTORE_PATH);
    console.log(`已删除旧 keystore: ${KEYSTORE_PATH}`);
  }

  const password = generatePassword();

  const cmd = [
    'keytool',
    '-genkeypair',
    `-alias "${ALIAS}"`,
    '-keyalg RSA',
    '-keysize 2048',
    `-validity ${VALIDITY_DAYS}`,
    `-keystore "${KEYSTORE_PATH}"`,
    `-storepass "${password}"`,
    `-keypass "${password}"`,
    `-dname "${DNAME}"`,
  ].join(' ');

  try {
    execSync(cmd, { stdio: 'inherit' });
  } catch (e) {
    console.error('keytool 执行失败，请确认系统已安装 JDK 并将其 keytool 加入 PATH');
    process.exit(1);
  }

  const properties = [
    `storePassword=${password}`,
    `keyPassword=${password}`,
    `keyAlias=${ALIAS}`,
    'storeFile=release-key.jks',
    '',
  ].join('\n');

  fs.writeFileSync(KEY_PROPERTIES_PATH, properties);

  console.log(`已生成 keystore: ${KEYSTORE_PATH}`);
  console.log(`已生成配置: ${KEY_PROPERTIES_PATH}`);
};

main();
