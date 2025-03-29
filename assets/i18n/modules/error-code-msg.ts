/* eslint-disable max-len */
import type { ILangMsgs } from "../type";

/*
 * 错误码 msg_
 */
const msg: ILangMsgs = {
  /*
   * 通用错误
   */
  'unknown_error': {
    en_US: 'Unknown error',
    zh_CN: '未知错误',
    zh_TW: '未知錯誤',
    es_ES: 'Error desconocido',
    fr_FR: 'Erreur inconnue',
    ru_RU: 'Неизвестная ошибка',
    it_IT: 'Errore sconosciuto',
    pt_PT: 'Erro desconhecido',
    de_DE: 'Unbekannter Fehler',
    ja_JP: '未知のエラー',
    ko_KR: '알 수 없는 오류',
    vi_VN: 'Lỗi không xác định',
  },
  'request_error': {
    en_US: 'Request error',
    zh_CN: '请求错误',
    zh_TW: '請求錯誤',
    es_ES: 'Error de solicitud',
    fr_FR: 'Erreur de requête',
    ru_RU: 'Ошибка запроса',
    it_IT: 'Errore di richiesta',
    pt_PT: 'Erro de solicitação',
    de_DE: 'Anfragefehler',
    ja_JP: 'リクエストエラー',
    ko_KR: '요청 오류',
    vi_VN: 'Lỗi yêu cầu',
  },

  /*
   * 服务器状态码
   */
  'status_400': {
    en_US: 'Request parameters are incorrect',
    zh_CN: '请求参数不正确',
    zh_TW: '請求參數不正確',
    es_ES: 'Parámetros de solicitud incorrectos',
    fr_FR: 'Les paramètres de la requête sont incorrects',
    ru_RU: 'Параметры запроса неверны',
    pt_PT: 'Os parâmetros da solicitação são incorretos',
    de_DE: 'Die Anforderungsparameter sind falsch',
    ja_JP: 'リクエストパラメータが正しくありません',
    it_IT: 'I parametri della richiesta sono errati',
    ko_KR: '계정이 로그인되지 않았습니다',
    vi_VN: 'Tài khoản chưa đăng nhập',
  },
  'status_401': {
    en_US: 'Account not logged in',
    zh_CN: '账号未登录',
    zh_TW: '賬號未登錄',
    es_ES: 'Sin permiso de operación',
    fr_FR: 'Pas de permission d\'opération',
    ru_RU: 'Нет прав на выполнение операции',
    pt_PT: 'Sem permissão de operação',
    de_DE: 'Keine Berechtigung für die Operation',
    ja_JP: '操作権限がありません',
    it_IT: 'Nessun permesso di operazione',
    ko_KR: '계정이 로그인되지 않았습니다',
    vi_VN: 'Tài khoản chưa đăng nhập',
  },
  'status_403': {
    en_US: 'No operation permission',
    zh_CN: '没有该操作权限',
    zh_TW: '沒有該操作權限',
    es_ES: 'Sin permiso de operación',
    fr_FR: 'Pas de permission d\'opération',
    ru_RU: 'Нет прав на выполнение операции',
    pt_PT: 'Sem permissão de operação',
    de_DE: 'Keine Berechtigung für die Operation',
    ja_JP: '操作権限がありません',
    it_IT: 'Nessun permesso di operazione',
    ko_KR: '계정이 로그인되지 않았습니다',
    vi_VN: 'Tài khoản chưa đăng nhập',
  },
  'status_500': {
    en_US: 'System busy, please try again later',
    zh_CN: '系统繁忙，请稍后重试',
    zh_TW: '系統繁忙，請稍後重試',
    es_ES: 'El sistema está ocupado, inténtelo de nuevo más tarde',
    fr_FR: 'Le système est occupé, veuillez réessayer plus tard',
    ru_RU: 'Система занята, попробуйте позже',
    pt_PT: 'O sistema está ocupado, tente novamente mais tarde',
    de_DE: 'System ist beschäftigt, bitte versuchen Sie es später erneut',
    ja_JP: 'システムが忙しいため、後で再試行してください',
    it_IT: 'Il sistema è occupato, riprova più tardi',
    ko_KR: '시스템이 혼잡하여 잠시 후 다시 시도해 주세요',
    vi_VN: 'Hệ thống đang bận, vui lòng thử lại sau',
  },

  /* 
   * 错误码
   */
  // 登录失败
  'code_1001002': {
    en_US: 'Login failed',
    zh_CN: '登录失败',
    zh_TW: '登錄失敗',
    es_ES: 'Inicio de sesión fallido',
    fr_FR: 'Connexion échouée',
    ru_RU: 'Вход в систему не выполнен',
    it_IT: 'Accesso non riuscito',
    pt_PT: 'Login falhou',
    de_DE: 'Der Benutzer existiert nicht',
    ja_JP: 'ユーザーが存在しません',
    ko_KR: '사용자가 존재하지 않습니다',
    vi_VN: 'Người dùng không tồn tại',
  },
};
export default msg;
