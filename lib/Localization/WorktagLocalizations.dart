import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:worktag/l10n/messages_all.dart';

class WorktagLocalizations {
  static Future<WorktagLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return WorktagLocalizations();
    });
  }

  static WorktagLocalizations of(BuildContext context) {
    return Localizations.of<WorktagLocalizations>(context, WorktagLocalizations);
  }

  String get title_date {
    return Intl.message(
      'Date',
      name: 'title_date',
      desc: 'Title for the date of the Entry',
    );
  }

  String get title_start {
    return Intl.message(
      'Start',
      name: 'title_start',
      desc: 'Title for the start of the Entry',
    );
  }

  String get title_end {
    return Intl.message(
      'End',
      name: 'title_end',
      desc: 'Title for the end of the Entry',
    );
  }

  String get title_break {
    return Intl.message(
      'Break',
      name: 'title_break',
      desc: 'Title for the break of the Entry',
    );
  }

  String get title_place {
    return Intl.message(
      'Place',
      name: 'title_place',
      desc: 'Title for the place of the Entry',
    );
  }

  String get title_submit {
    return Intl.message(
      'Submit',
      name: 'title_submit',
      desc: 'Title for the submit button',
    );
  }

  String get title_modify {
    return Intl.message(
      'Modify',
      name: 'title_modify',
      desc: 'Title for the modify button',
    );
  }

  String get title_delete {
    return Intl.message(
      'Delete',
      name: 'title_delete',
      desc: 'Title for the delete button',
    );
  }

  String get screen_edit {
    return Intl.message(
      'Edit Entry',
      name: 'screen_edit',
      desc: 'Title for the edit screen',
    );
  }
}

class WorktagLocalizationsDelegate extends LocalizationsDelegate<WorktagLocalizations> {
  const WorktagLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<WorktagLocalizations> load(Locale locale) => WorktagLocalizations.load(locale);

  @override
  bool shouldReload(WorktagLocalizationsDelegate old) => false;
}