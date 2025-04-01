import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// No description provided for @lang_name.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang_name;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @language_setting.
  ///
  /// In en, this message translates to:
  /// **'Language Setting'**
  String get language_setting;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @theme_follow_system.
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get theme_follow_system;

  /// No description provided for @theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_dark;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @this_month.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get this_month;

  /// No description provided for @this_quarter.
  ///
  /// In en, this message translates to:
  /// **'This Quarter'**
  String get this_quarter;

  /// No description provided for @user_agreement.
  ///
  /// In en, this message translates to:
  /// **'《User Agreement》'**
  String get user_agreement;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'《Privacy Policy》'**
  String get privacy_policy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @btn_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get btn_copy;

  /// No description provided for @btn_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get btn_login;

  /// No description provided for @btn_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get btn_logout;

  /// No description provided for @title_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get title_home;

  /// No description provided for @title_me.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get title_me;

  /// No description provided for @title_setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get title_setting;

  /// No description provided for @title_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get title_about;

  /// No description provided for @title_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get title_version;

  /// No description provided for @title_scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get title_scan;

  /// No description provided for @title_scan_result.
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get title_scan_result;

  /// No description provided for @info_please_input.
  ///
  /// In en, this message translates to:
  /// **'Please input'**
  String get info_please_input;

  /// No description provided for @info_have_read_and_agree.
  ///
  /// In en, this message translates to:
  /// **'Have read and agreed'**
  String get info_have_read_and_agree;

  /// No description provided for @info_pull_down_refresh.
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh'**
  String get info_pull_down_refresh;

  /// No description provided for @info_release_refresh.
  ///
  /// In en, this message translates to:
  /// **'Release to refresh'**
  String get info_release_refresh;

  /// No description provided for @info_start_refresh.
  ///
  /// In en, this message translates to:
  /// **'Start refreshing...'**
  String get info_start_refresh;

  /// No description provided for @info_refreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing'**
  String get info_refreshing;

  /// No description provided for @info_refresh_complete.
  ///
  /// In en, this message translates to:
  /// **'Refresh complete'**
  String get info_refresh_complete;

  /// No description provided for @info_refresh_failed.
  ///
  /// In en, this message translates to:
  /// **'Refresh failed'**
  String get info_refresh_failed;

  /// No description provided for @info_pull_up_load.
  ///
  /// In en, this message translates to:
  /// **'Pull up to load more'**
  String get info_pull_up_load;

  /// No description provided for @info_release_load.
  ///
  /// In en, this message translates to:
  /// **'Release to load more'**
  String get info_release_load;

  /// No description provided for @info_start_load.
  ///
  /// In en, this message translates to:
  /// **'Start loading'**
  String get info_start_load;

  /// No description provided for @info_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get info_loading;

  /// No description provided for @info_load_complete.
  ///
  /// In en, this message translates to:
  /// **'Load complete'**
  String get info_load_complete;

  /// No description provided for @info_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get info_load_failed;

  /// No description provided for @info_no_more_data.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get info_no_more_data;

  /// No description provided for @info_last_updated.
  ///
  /// In en, this message translates to:
  /// **'Last updated at %T'**
  String get info_last_updated;

  /// No description provided for @info_data_empty.
  ///
  /// In en, this message translates to:
  /// **'Data is empty'**
  String get info_data_empty;

  /// No description provided for @msg_query_failed.
  ///
  /// In en, this message translates to:
  /// **'Query failed'**
  String get msg_query_failed;

  /// No description provided for @msg_operation_failed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get msg_operation_failed;

  /// No description provided for @msg_copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get msg_copied;

  /// No description provided for @msg_content_empty.
  ///
  /// In en, this message translates to:
  /// **'Content is empty'**
  String get msg_content_empty;

  /// No description provided for @msg_scan_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Scan permission denied'**
  String get msg_scan_permission_denied;

  /// No description provided for @msg_device_scan_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Scanning is unsupported on this device'**
  String get msg_device_scan_unsupported;

  /// No description provided for @msg_scan_failed.
  ///
  /// In en, this message translates to:
  /// **'Scan failed'**
  String get msg_scan_failed;

  /// No description provided for @msg_no_barcode_detected.
  ///
  /// In en, this message translates to:
  /// **'No barcode or QR code detected'**
  String get msg_no_barcode_detected;

  /// No description provided for @msg_read_agreement.
  ///
  /// In en, this message translates to:
  /// **'Please read the agreement first'**
  String get msg_read_agreement;

  /// No description provided for @msg_login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get msg_login_failed;

  /// No description provided for @msg_logout.
  ///
  /// In en, this message translates to:
  /// **'Logged out'**
  String get msg_logout;

  /// No description provided for @msg_login_success.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get msg_login_success;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknown_error;

  /// No description provided for @request_error.
  ///
  /// In en, this message translates to:
  /// **'Request error'**
  String get request_error;

  /// No description provided for @status_400.
  ///
  /// In en, this message translates to:
  /// **'Request parameters are incorrect'**
  String get status_400;

  /// No description provided for @status_401.
  ///
  /// In en, this message translates to:
  /// **'Account not logged in'**
  String get status_401;

  /// No description provided for @status_403.
  ///
  /// In en, this message translates to:
  /// **'No operation permission'**
  String get status_403;

  /// No description provided for @status_500.
  ///
  /// In en, this message translates to:
  /// **'System busy, please try again later'**
  String get status_500;

  /// No description provided for @code_1001002.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get code_1001002;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it', 'ja', 'ko', 'pt', 'ru', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.scriptCode) {
    case 'Hant': return AppLocalizationsZhHant();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'pt': return AppLocalizationsPt();
    case 'ru': return AppLocalizationsRu();
    case 'vi': return AppLocalizationsVi();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
