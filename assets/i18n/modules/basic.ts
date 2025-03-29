import type { ILangMsgs } from "../type";

/*
 * 基础信息
 */
const msg: ILangMsgs = {
  lang_name: {
    zh_CN: "中文（简体）",
    zh_TW: "中文（繁体）",
    en_US: "English",
    ru_RU: "Русский",
    fr_FR: "Français",
    es_ES: "Español",
    it_IT: "Italiano",
    pt_PT: "Português",
    de_DE: "Deutsch",
    ja_JP: "日本語",
    ko_KR: "한국어",
    vi_VN: "Tiếng Việt",
  },
  // 语言
  language: {
    zh_CN: "语言",
    zh_TW: "語言",
    en_US: "Language",
    ru_RU: "Язык",
    fr_FR: "Langue",
    es_ES: "Idioma",
    it_IT: "Lingua",
    pt_PT: "Idioma",
    de_DE: "Sprache",
    ja_JP: "言語",
    ko_KR: "언어",
    vi_VN: "Ngôn ngữ",
  },
  // 语言设置
  language_setting: {
    zh_CN: "语言设置",
    zh_TW: "語言設定",
    en_US: "Language Setting",
    ru_RU: "Настройки языка",
    fr_FR: "Paramètres linguistiques",
    es_ES: "Configuración de idioma",
    it_IT: "Impostazioni lingua",
    pt_PT: "Configuração de idioma",
    de_DE: "Spracheinstellungen",
    ja_JP: "言語設定",
    ko_KR: "언어 설정",
    vi_VN: "Cài đặt ngôn ngữ",
  },

  /* 
   * 主题
   */
  theme: {
    zh_CN: "主题",
    zh_TW: "主題",
    en_US: "Theme",
    ru_RU: "Тема",
    fr_FR: "Thème",
    es_ES: "Tema",
    it_IT: "Tema",
    pt_PT: "Tema",
    de_DE: "Thema",
    ja_JP: "テーマ",
    ko_KR: "테마",
    vi_VN: "Chủ đề",
  },
  // 跟随系统
  theme_follow_system: {
    zh_CN: "跟随系统",
    zh_TW: "跟隨系統",
    en_US: "Follow System",
    ru_RU: "Следуйте системе",
    fr_FR: "Suivez le système",
    es_ES: "Siga el sistema",
    it_IT: "Segui il sistema",
    pt_PT: "Siga o sistema",
    de_DE: "Folgen Sie dem System",
    ja_JP: "システムに従う",
    ko_KR: "시스템을 따르다",
    vi_VN: "Theo hệ thống",
  },
  // 浅色
  theme_light: {
    zh_CN: "浅色",
    zh_TW: "淺色",
    en_US: "Light",
    ru_RU: "Светлый",
    fr_FR: "Clair",
    es_ES: "Claro",
    it_IT: "Chiaro",
    pt_PT: "Claro",
    de_DE: "Hell",
    ja_JP: "明るい",
    ko_KR: "밝은",
    vi_VN: "Sáng",
  },
  // 深色
  theme_dark: {
    zh_CN: "深色",
    zh_TW: "深色",
    en_US: "Dark",
    ru_RU: "Темный",
    fr_FR: "Sombre",
    es_ES: "Oscuro",
    it_IT: "Scuro",
    pt_PT: "Escuro",
    de_DE: "Dunkel",
    ja_JP: "暗い",
    ko_KR: "어두운",
    vi_VN: "Tối",
  },
  
  /*
   * 时间筛选
   */
  // 今天
  today: {
    zh_CN: "今天",
    zh_TW: "今天",
    en_US: "Today",
    ru_RU: "Сегодня",
    fr_FR: "Aujourd'hui",
    es_ES: "Hoy",
    it_IT: "Oggi",
    pt_PT: "Hoje",
    de_DE: "Heute",
    ja_JP: "今日",
    ko_KR: "오늘",
    vi_VN: "Hôm nay",
  },
  // 昨天
  yesterday: {
    zh_CN: "昨天",
    zh_TW: "昨天",
    en_US: "Yesterday",
    ru_RU: "Вчера",
    fr_FR: "Hier",
    es_ES: "Ayer",
    it_IT: "Ieri",
    pt_PT: "Ontem",
    de_DE: "Gestern",
    ja_JP: "昨日",
    ko_KR: "어제",
    vi_VN: "Hôm qua",
  },
  // 本月
  this_month: {
    zh_CN: "本月",
    zh_TW: "本月",
    en_US: "This Month",
    ru_RU: "Этот месяц",
    fr_FR: "Ce mois-ci",
    es_ES: "Este mes",
    it_IT: "Questo mese",
    pt_PT: "Este mês",
    de_DE: "Dieser Monat",
    ja_JP: "今月",
    ko_KR: "이번 달",
    vi_VN: "Tháng này",
  },
  // 本季
  this_quarter: {
    zh_CN: "本季",
    zh_TW: "本季",
    en_US: "This Quarter",
    ru_RU: "Этот квартал",
    fr_FR: "Ce trimestre",
    es_ES: "Este trimestre",
    it_IT: "Questo trimestre",
    pt_PT: "Este trimestre",
    de_DE: "Dieses Quartal",
    ja_JP: "今の四半期",
    ko_KR: "이번 분기",
    vi_VN: "Quý này",
  },

  /*
   * 用户协议
   */
  user_agreement: {
    zh_CN: "《用户协议》",
    zh_TW: "《用戶協議》",
    en_US: "《User Agreement》",
    ru_RU: "《Пользовательское соглашение》",
    fr_FR: "《Les conditions d'utilisation》",
    es_ES: "《Acuerdo de Usuario》",
    it_IT: "《Accordo Utente》",
    pt_PT: "《Termos de Uso》",
    de_DE: "《Benutzervereinbarung》",
    ja_JP: "《ユーザー契約》",
    ko_KR: "《사용자 계약》",
    vi_VN: "《Thỏa thuận người dùng》",
  },
  privacy_policy: {
    zh_CN: "《隐私政策》",
    zh_TW: "《隱私政策》",
    en_US: "《Privacy Policy》",
    ru_RU: "《Политика конфиденциальности》",
    fr_FR: "《Politique de confidentialité》",
    es_ES: "《Política de privacidad》",
    it_IT: "《Politica sulla riservatezza》",
    pt_PT: "《Política de Privacidade》",
    de_DE: "《Datenschutzrichtlinie》",
    ja_JP: "《プライバシーポリシー》",
    ko_KR: "《개인정보 정책》",
    vi_VN: "《Chính sách bảo mật》",
  },
  // 和
  and: {
    zh_CN: "和",
    zh_TW: "和",
    en_US: "and",
    ru_RU: "и",
    fr_FR: "et",
    es_ES: "y",
    it_IT: "e",
    pt_PT: "e",
    de_DE: "und",
    ja_JP: "と",
    ko_KR: "와",
    vi_VN: "và",
  },

  /* 
   * 用户字段
   */
  /* 账号 */
  account: {
    zh_CN: "账号",
    zh_TW: "帳號",
    en_US: "Account",
    ru_RU: "Аккаунт",
    fr_FR: "Compte",
    es_ES: "Cuenta",
    it_IT: "Account",
    pt_PT: "Conta",
    de_DE: "Konto",
    ja_JP: "アカウント",
    ko_KR: "계정",
    vi_VN: "Tài khoản",
  },
  /* 密码 */
  password: {
    zh_CN: "密码",
    zh_TW: "密碼",
    en_US: "Password",
    ru_RU: "Пароль",
    fr_FR: "Mot de passe",
    es_ES: "Contraseña",
    it_IT: "Password",
    pt_PT: "Palavra-passe",
    de_DE: "Passwort",
    ja_JP: "パスワード",
    ko_KR: "비밀번호",
    vi_VN: "Mật khẩu",
  },
};

export default msg;
