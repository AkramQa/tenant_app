// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tenant_app/core/l10n/translations/intl_ar.dart';
import 'package:tenant_app/core/l10n/translations/intl_en.dart';

/// App strings (English + Arabic). Access with `context.l10n.some_key`.
///
/// To add a string: add the key to both `translations/intl_*.dart` maps and
/// expose it with a getter below.
class AppLocalizations {
  AppLocalizations(this.locale) : _strings = _translations[locale.languageCode] ?? intlEn;

  final Locale locale;
  final Map<String, String> _strings;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  static const Map<String, Map<String, String>> _translations = {'en': intlEn, 'ar': intlAr};

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  String _t(String key) => _strings[key] ?? intlEn[key] ?? key;

  String get app_name => _t('app_name');

  String get app_tagline => _t('app_tagline');

  String get welcome_back => _t('welcome_back');

  String get sign_in_to_manage_your_home_services => _t('sign_in_to_manage_your_home_services');

  String get email_or_phone_number => _t('email_or_phone_number');

  String get email_or_phone_number_hint => _t('email_or_phone_number_hint');

  String get password => _t('password');

  String get enter_your_password => _t('enter_your_password');

  String get show_password => _t('show_password');

  String get hide_password => _t('hide_password');

  String get sign_in => _t('sign_in');

  String get demo_account => _t('demo_account');

  String demo_account_details(String email, String phone, String password) => _t(
    'demo_account_details',
  ).replaceAll('{email}', email).replaceAll('{phone}', phone).replaceAll('{password}', password);

  String get use_demo_account => _t('use_demo_account');

  String get incorrect_email_phone_or_password => _t('incorrect_email_phone_or_password');

  String get logout => _t('logout');

  String get logout_confirmation_title => _t('logout_confirmation_title');

  String get logout_confirmation_message => _t('logout_confirmation_message');

  String get field_required_message => _t('field_required_message');

  String get invalid_email_error_message => _t('invalid_email_error_message');

  String get invalid_email_or_phone_number => _t('invalid_email_or_phone_number');

  String min_length_error_message(int count) => _t('min_length_error_message').replaceAll('{count}', '$count');

  String password_must_be_at_least_n_characters(int count) =>
      _t('password_must_be_at_least_n_characters').replaceAll('{count}', '$count');

  String description_must_be_at_least_n_characters(int count) =>
      _t('description_must_be_at_least_n_characters').replaceAll('{count}', '$count');

  String get please_choose_a_service_type => _t('please_choose_a_service_type');

  String get please_choose_a_preferred_date => _t('please_choose_a_preferred_date');

  String get error_message => _t('error_message');

  String get no_internet_connection_message => _t('no_internet_connection_message');

  String get server_not_working => _t('server_not_working');

  String get cache_error_message => _t('cache_error_message');

  String get something_went_wrong => _t('something_went_wrong');

  String get no_internet_connection => _t('no_internet_connection');

  String get looks_like_you_are_offline_please_check_your_connection_and_try_again =>
      _t('looks_like_you_are_offline_please_check_your_connection_and_try_again');

  String get we_couldnt_load_the_data_please_try_again => _t('we_couldnt_load_the_data_please_try_again');

  String get the_requested_item_was_not_found => _t('the_requested_item_was_not_found');

  String get could_not_access_photos => _t('could_not_access_photos');

  String get you_are_viewing_saved_data => _t('you_are_viewing_saved_data');

  String get retry => _t('retry');

  String get success => _t('success');

  String get cancel => _t('cancel');

  String get done => _t('done');

  String get close => _t('close');

  String get yes => _t('yes');

  String get no => _t('no');

  String get all => _t('all');

  String get unknown => _t('unknown');

  String get view_all => _t('view_all');

  String get home => _t('home');

  String get requests => _t('requests');

  String get profile => _t('profile');

  String get welcome_home => _t('welcome_home');

  String unit_number(String unit) => _t('unit_number').replaceAll('{unit}', unit);

  String get quick_services => _t('quick_services');

  String get recent_requests => _t('recent_requests');

  String get new_request => _t('new_request');

  String get service_maintenance => _t('service_maintenance');

  String get service_plumbing => _t('service_plumbing');

  String get service_electrical => _t('service_electrical');

  String get service_ac_maintenance => _t('service_ac_maintenance');

  String get service_cleaning => _t('service_cleaning');

  String get status_pending => _t('status_pending');

  String get status_assigned => _t('status_assigned');

  String get status_in_progress => _t('status_in_progress');

  String get status_completed => _t('status_completed');

  String get status_pending_description => _t('status_pending_description');

  String get status_assigned_description => _t('status_assigned_description');

  String get status_in_progress_description => _t('status_in_progress_description');

  String get status_completed_description => _t('status_completed_description');

  String get current_status => _t('current_status');

  String get service_requests => _t('service_requests');

  String requested_on(String date) => _t('requested_on').replaceAll('{date}', date);

  String get urgent => _t('urgent');

  String get no_service_requests_yet => _t('no_service_requests_yet');

  String get no_service_requests_yet_description => _t('no_service_requests_yet_description');

  String no_requests_with_status(String status) => _t('no_requests_with_status').replaceAll('{status}', status);

  String get try_a_different_filter => _t('try_a_different_filter');

  String get new_service_request => _t('new_service_request');

  String get service_type => _t('service_type');

  String get description => _t('description');

  String get description_hint => _t('description_hint');

  String get preferred_date => _t('preferred_date');

  String get select_a_date => _t('select_a_date');

  String get urgent_request => _t('urgent_request');

  String get urgent_request_description => _t('urgent_request_description');

  String get photo_optional => _t('photo_optional');

  String get add_photo => _t('add_photo');

  String get add_photo_hint => _t('add_photo_hint');

  String get take_photo => _t('take_photo');

  String get choose_from_gallery => _t('choose_from_gallery');

  String get change_photo => _t('change_photo');

  String get remove_photo => _t('remove_photo');

  String get submit_request => _t('submit_request');

  String get request_details => _t('request_details');

  String get progress => _t('progress');

  String get details => _t('details');

  String get created_on => _t('created_on');

  String get status => _t('status');

  String get attached_photo => _t('attached_photo');

  String get no_photo_attached => _t('no_photo_attached');

  String get could_not_attach_photo => _t('could_not_attach_photo');

  String get request_number => _t('request_number');

  String get request_submitted_title => _t('request_submitted_title');

  String request_submitted_description(String type) => _t('request_submitted_description').replaceAll('{type}', type);

  String get view_request => _t('view_request');

  String get back_to_home => _t('back_to_home');

  String get photo_unavailable => _t('photo_unavailable');

  String get contact_information => _t('contact_information');

  String get email => _t('email');

  String get phone_number => _t('phone_number');

  String get settings => _t('settings');

  String get language => _t('language');

  String get theme => _t('theme');

  String get system_default => _t('system_default');

  String get light => _t('light');

  String get dark => _t('dark');

  String get simulate_offline_mode => _t('simulate_offline_mode');

  String get simulate_offline_mode_description => _t('simulate_offline_mode_description');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.any((supported) => supported.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
