import type { ILangMsgs } from "../type";

/*
 * 提示信息 msg_
 */
const msg: ILangMsgs = {
  // 查询失败
  msg_query_failed: {
    zh_CN: "查询失败",
    zh_TW: "查詢失敗",
    en_US: "Query failed",
    ru_RU: "Не удалось выполнить запрос",
    fr_FR: "La requête a échoué",
    es_ES: "La consulta falló",
    it_IT: "La query non è riuscita",
    pt_PT: "A consulta falhou",
    de_DE: "Die Abfrage ist fehlgeschlagen",
    ja_JP: "クエリに失敗しました",
    ko_KR: "쿼리에 실패했습니다",
    vi_VN: "Truy vấn không thành công",
  },
  // 操作失败
  msg_operation_failed: {
    zh_CN: "操作失败",
    zh_TW: "操作失敗",
    en_US: "Operation failed",
    ru_RU: "Операция не удалась",
    fr_FR: "L'opération a échoué",
    es_ES: "La operación falló",
    it_IT: "L'operazione non è riuscita",
    pt_PT: "A operação falhou",
    de_DE: "Die Operation ist fehlgeschlagen",
    ja_JP: "操作に失敗しました",
    ko_KR: "작업에 실패했습니다",
    vi_VN: "Hoạt động không thành công",
  },

  /* 
   * 扫码
   */
  // 申请扫码权限被拒绝
  msg_scan_permission_denied: {
    zh_CN: "申请扫码权限被拒绝",
    zh_TW: "申請掃碼權限被拒絕",
    en_US: "Scan permission denied",
    ru_RU: "Разрешение сканирования отклонено",
    fr_FR: "Permission de scan refusée",
    es_ES: "Permiso de escaneo denegado",
    it_IT: "Permesso di scansione negato",
    pt_PT: "Permissão de escaneamento negada",
    de_DE: "Scannen-Berechtigung wurde abgelehnt",
    ja_JP: "スキャン許可が拒否されました",
    ko_KR: "스캔 권한이 거부되었습니다",
    vi_VN: "Quyền truy cập quét đã bị từ chối",
  },
  // 当前设备不支持扫码
  msg_device_scan_unsupported: {
    zh_CN: "当前设备不支持扫码",
    zh_TW: "當前設備不支持掃碼",
    en_US: "Scanning is unsupported on this device",
    ru_RU: "Сканирование не поддерживается на этом устройстве",
    fr_FR: "Le scan n'est pas pris en charge sur cet appareil",
    es_ES: "El escaneo no es compatible con este dispositivo",
    it_IT: "Lo scan non è compatibile con questo dispositivo",
    pt_PT: "O escaneamento não é compatível com este dispositivo",
    de_DE: "Scannen ist auf diesem Gerät nicht möglich",
    ja_JP: "このデバイスではスキャンできません",
    ko_KR: "이 기기에서는 스캔할 수 없습니다",
    vi_VN: "Quét không thành công trên thiết bị này",
  },
  // 扫码失败
  msg_scan_failed: {
    zh_CN: "扫码失败",
    zh_TW: "掃碼失敗",
    en_US: "Scan failed",
    ru_RU: "Сканирование не удалось",
    fr_FR: "Le scan a échoué",
    es_ES: "El escaneo falló",
    it_IT: "Lo scan non è riuscito",
    pt_PT: "O escaneamento falhou",
    de_DE: "Der Scan ist fehlgeschlagen",
    ja_JP: "スキャンに失敗しました",
    ko_KR: "스캔에 실패했습니다",
    vi_VN: "Quét không thành công",
  },
  
  /* 
   * 登录
   */
  // 请先阅读协议
  msg_read_agreement: {
    zh_CN: "请先阅读协议",
    zh_TW: "請先閱讀協議",
    en_US: "Please read the agreement first",
    ru_RU: "Пожалуйста, прочитайте соглашение",
    fr_FR: "Veuillez d'abord lire l'accord",
    es_ES: "Por favor lea el acuerdo primero",
    it_IT: "Leggi prima l'accordo",
    pt_PT: "Leia primeiro o acordo",
    de_DE: "Bitte lesen Sie zuerst die Vereinbarung",
    ja_JP: "最初に契約を読み",
    ko_KR: "먼저 계약을 읽으십시오",
    vi_VN: "Vui lòng đọc thỏa thuận trước",
  },
  // 登录失败
  msg_login_failed: {
    zh_CN: "登录失败",
    zh_TW: "登入失敗",
    en_US: "Login Failed",
    ru_RU: "Вход не выполнен",
    fr_FR: "La connexion a échoué",
    es_ES: "La conexión falló",
    it_IT: "L'accesso non è riuscito",
    pt_PT: "A conexão falhou",
    de_DE: "Die Anmeldung ist fehlgeschlagen",
    ja_JP: "ログインに失敗しました",
    ko_KR: "로그인에 실패했습니다",
    vi_VN: "Đăng nhập không thành công"
  },
};



export default msg;
