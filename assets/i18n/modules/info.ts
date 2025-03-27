import type { ILangMsgs } from "../type";

/*
 * 界面信息 btn_
 */
const msg: ILangMsgs = {
  // 已阅读并同意
  info_have_read_and_agree: {
    zh_CN: "已阅读并同意",
    zh_TW: "已閱讀並同意",
    en_US: "Have read and agreed",
    ru_RU: "Прочитано и согласен",
    fr_FR: "Lu et accepté",
    es_ES: "Leído y aceptado",
    it_IT: "Legato e accettato",
    pt_PT: "Lido e aceito",
    de_DE: "Gelesen und akzeptiert",
    ja_JP: "既読と同意",
    ko_KR: "읽고 약속",
    vi_VN: "Đã đọcvà đồng ý",
  },
  /* 下拉刷新 */
  // 下拉刷新
  info_pull_down_refresh: {
    zh_CN: "下拉刷新",
    zh_TW: "下拉刷新",
    en_US: "Pull down to refresh",
    ru_RU: "Потяните, чтобы обновить",
    fr_FR: "Tirez vers le bas pour rafraîchir",
    es_ES: "Tire hacia abajo para refrescar",
    it_IT: "Tira giù per aggiornare",
    pt_PT: "Arraste para baixo para atualizar",
    de_DE: "Ziehen Sie nach unten, um zu aktualisieren",
    ja_JP: "下に引いて更新",
    ko_KR: "새로고침 하려면 아래로 밀어",
    vi_VN: "Kéo xuống để làm mới",
  },
  // 松开刷新
  info_release_refresh: {
    zh_CN: "松开刷新",
    zh_TW: "鬆開刷新",
    en_US: "Release to refresh",
    ru_RU: "Отпустите, чтобы обновить",
    fr_FR: "Relâchez pour rafraîchir",
    es_ES: "Suelta para refrescar",
    it_IT: "Rilascia per aggiornare",
    pt_PT: "Soltar para atualizar",
    de_DE: "Loslassen, um zu aktualisieren",
    ja_JP: "リリースして更新",
    ko_KR: "새로고침하려면  vrijlaten",
    vi_VN: "Thả ra để làm mới",
  },
  // 开始刷新...
  info_start_refresh: {
    zh_CN: "开始刷新...",
    zh_TW: "開始刷新...",
    en_US: "Start refreshing...",
    ru_RU: "Начать обновление...",
    fr_FR: "Démarrer la mise à jour...",
    es_ES: "Empezar a refrescar...",
    it_IT: "Inizia a aggiornare...",
    pt_PT: "Iniciar atualização...",
    de_DE: "Starten Sie die Aktualisierung...",
    ja_JP: "更新を開始...",
    ko_KR: "새로고침 시작...",
    vi_VN: "Bắt đầu làm mới...",
  },
  // 正在刷新
  info_refreshing: {
    zh_CN: "正在刷新",
    zh_TW: "正在刷新",
    en_US: "Refreshing",
    ru_RU: "Обновление",
    fr_FR: "Rafraîchissement",
    es_ES: "Actualización",
    it_IT: "Aggiornamento",
    pt_PT: "Atualização",
    de_DE: "Aktualisierung",
    ja_JP: "更新中",
    ko_KR: "새로고침",
    vi_VN: "Làm mới",
  },
  // 刷新完成
  info_refresh_complete: {
    zh_CN: "刷新完成",
    zh_TW: "刷新完成",
    en_US: "Refresh complete",
    ru_RU: "Обновление завершено",
    fr_FR: "Rafraîchissement terminé",
    es_ES: "Actualización completa",
    it_IT: "Aggiornamento completato",
    pt_PT: "Atualização completa",
    de_DE: "Aktualisierung abgeschlossen",
    ja_JP: "更新完了",
    ko_KR: "새로고침 완료",
    vi_VN: "Làm mới hoàn thành",
  },
  // 刷新失败
  info_refresh_failed: {
    zh_CN: "刷新失败",
    zh_TW: "刷新失敗",
    en_US: "Refresh failed",
    ru_RU: "Не удалось обновить",
    fr_FR: "Échec de la mise à jour",
    es_ES: "La actualización falló",
    it_IT: "L'aggiornamento non è riuscito",
    pt_PT: "A atualização falhou",
    de_DE: "Aktualisierung fehlgeschlagen",
    ja_JP: "更新に失敗しました",
    ko_KR: "새로고침에 실패했습니다",
    vi_VN: "Làm mới không thành công",
  },
  // 上拉加载
  info_pull_up_load: {
    zh_CN: "上拉加载",
    zh_TW: "上拉加載",
    en_US: "Pull up to load more",
    ru_RU: "Потяните, чтобы загрузить больше",
    fr_FR: "Tirez vers le haut pour charger plus",
    es_ES: "Tire hacia arriba para cargar más",
    it_IT: "Tira su per caricare altro",
    pt_PT: "Arraste para cima para carregar mais",
    de_DE: "Ziehen Sie nach oben, um mehr zu laden",
    ja_JP: "上に引いて読み込む",
    ko_KR: "더 많은 데이터를 로드하려면 아래로 밀어",
    vi_VN: "Kéo lên để tải thêm",
  },
  // 松开加载
  info_release_load: {
    zh_CN: "松开加载",
    zh_TW: "鬆開加載",
    en_US: "Release to load more",
    ru_RU: "Отпустите, чтобы загрузить больше",
    fr_FR: "Relâchez pour charger plus",
    es_ES: "Suelta para cargar más",
    it_IT: "Rilascia per caricare altro",
    pt_PT: "Soltar para carregar mais",
    de_DE: "Loslassen, um mehr zu laden",
    ja_JP: "リリースして読み込む",
    ko_KR: "더 많은 데이터를 로드하려면  vrij",
    vi_VN: "Thả ra để tải thêm",
  },
  // 开始加载
  info_start_load: {
    zh_CN: "开始加载",
    zh_TW: "開始加載",
    en_US: "Start loading",
    ru_RU: "Начать загрузку",
    fr_FR: "Démarrer le chargement",
    es_ES: "Empezar a cargar",
    it_IT: "Inizia a caricare",
    pt_PT: "Iniciar carregamento",
    de_DE: "Starten Sie die Ladeung",
    ja_JP: "読み込みを開始",
    ko_KR: "로드 시작",
    vi_VN: "Bắt đầu tải",
  },
  // 正在加载
  info_loading: {
    zh_CN: "正在加载",
    zh_TW: "正在加載",
    en_US: "Loading",
    ru_RU: "Загрузка",
    fr_FR: "Chargement",
    es_ES: "Cargando",
    it_IT: "Caricamento",
    pt_PT: "Carregando",
    de_DE: "Ladeung",
    ja_JP: "読み込み中",
    ko_KR: "로드 중",
    vi_VN: "Đang tải",
  },
  // 加载完成
  info_load_complete: {
    zh_CN: "加载完成",
    zh_TW: "加載完成",
    en_US: "Load complete",
    ru_RU: "Загрузка завершена",
    fr_FR: "Chargement terminé",
    es_ES: "Carga completa",
    it_IT: "Caricamento completato",
    pt_PT: "Carregamento completo",
    de_DE: "Ladeung abgeschlossen",
    ja_JP: "読み込み完了",
    ko_KR: "로드 완료",
    vi_VN: "Tải hoàn thành",
  },
  // 加载失败
  info_load_failed: {
    zh_CN: "加载失败",
    zh_TW: "加載失敗",
    en_US: "Load failed",
    ru_RU: "Не удалось загрузить",
    fr_FR: "Échec du chargement",
    es_ES: "La carga falló",
    it_IT: "Il caricamento non è riuscito",
    pt_PT: "A carga falhou",
    de_DE: "Ladeung fehlgeschlagen",
    ja_JP: "読み込みに失敗しました",
    ko_KR: "로드에 실패했습니다",
    vi_VN: "Tải không thành công",
  },
  // 没有更多数据
  info_no_more_data: {
    zh_CN: "没有更多数据",
    zh_TW: "沒有更多數據",
    en_US: "No more data",
    ru_RU: "Нет больше данных",
    fr_FR: "Pas plus de données",
    es_ES: "Sin más datos",
    it_IT: "Nessun altro dato",
    pt_PT: "Sem mais dados",
    de_DE: "Keine weitere Daten",
    ja_JP: "データなし",
    ko_KR: "더 이상 데이터가 없습니다",
    vi_VN: "Không có dữ liệu nào",
  },
  // 最后更新于
  info_last_updated: {
    zh_CN: "最后更新于  %T",
    zh_TW: "最後更新於  %T",
    en_US: "Last updated at %T",
    ru_RU: "Последнее обновление в %T",
    fr_FR: "Dernière mise à jour à %T",
    es_ES: "Última actualización a las %T",
    it_IT: "Ultimo aggiornamento alle %T",
    pt_PT: "Atualizado pela última vez às %T",
    de_DE: "Zuletzt aktualisiert um %T",
    ja_JP: "最終更新 %T",
    ko_KR: "마지막 업데이트 %T",
    vi_VN: "Cập nhật cuối cùng vào %T",
  },
};

export default msg;
