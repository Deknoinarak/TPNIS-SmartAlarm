import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ScheduleNotifications with HandleError {
  ScheduleNotifications(
      this.channelId, this.channelName, this.channelDescription,
      {String? appIcon}) {
    if (appIcon == null || appIcon.trim().isEmpty) {
      // Assign the app's icon.
      _appIcon = '@mipmap/ic_launcher';
    } else {
      _appIcon = appIcon.trim();
    }
  }

  String? _appIcon;

  /// The channel's id.
  /// Required for Android 8.0+.
  final String? channelId;

  /// The channel's name.
  /// Required for Android 8.0+.
  final String? channelName;

  /// The channel's description.
  /// Required for Android 8.0+.
  final String? channelDescription;

  DateTime? _schedule;
  String? _title;
  String? _body;
  String? _payload;
  bool? _androidAllowWhileIdle;
  String? _icon;
  Importance? _importance;
  Priority? _priority;
  StyleInformation? _styleInformation;
  bool? _playSound;
  AndroidNotificationSound? _sound;
  bool? _enableVibration;
  List<int>? _vibrationPattern;
  String? _groupKey;
  bool? _setAsGroupSummary;
  GroupAlertBehavior? _groupAlertBehavior;
  bool? _autoCancel;
  bool? _ongoing;
  Color? _color;
  AndroidBitmap? _largeIcon;
  bool? _onlyAlertOnce;
  bool? _showWhen;
  bool? _channelShowBadge;
  bool? _showProgress;
  int? _maxProgress;
  int? _progress;
  bool? _indeterminate;
  AndroidNotificationChannelAction? _channelAction;
  bool? _enableLights;
  Color? _ledColor;
  int? _ledOnMs;
  int? _ledOffMs;
  String? _ticker;
  NotificationVisibility? _visibility;
  int? _timeoutAfter;
  AndroidNotificationCategory? _category;
  DidReceiveNotificationResponseCallback? _selectNotificationCallback;
  bool? _requestAlertPermission;
  bool? _requestSoundPermission;
  bool? _requestBadgePermission;
  bool? _defaultPresentAlert;
  bool? _defaultPresentSound;
  bool? _defaultPresentBadge;
  DidReceiveLocalNotificationCallback? _onDidReceiveLocalNotification;
  bool? _presentAlert;
  bool? _presentSound;
  bool? _presentBadge;
  String? _soundFile;
  int? _badgeNumber;

  @mustCallSuper
  Future<bool> init({
    String? appIcon,
    DateTime? schedule,
    String? title,
    String? body,
    String? payload,
    bool? androidAllowWhileIdle,
    String? icon,
    Importance? importance,
    Priority? priority,
    StyleInformation? styleInformation,
    bool? playSound = true,
    AndroidNotificationSound? sound,
    bool? enableVibration,
    List<int>? vibrationPattern,
    String? groupKey,
    bool? setAsGroupSummary,
    GroupAlertBehavior? groupAlertBehavior,
    bool? autoCancel,
    bool? ongoing,
    Color? color,
    AndroidBitmap? largeIcon,
    bool? onlyAlertOnce,
    bool? showWhen,
    bool? channelShowBadge,
    bool? showProgress,
    int? maxProgress,
    int? progress,
    bool? indeterminate,
    AndroidNotificationChannelAction? channelAction,
    bool? enableLights,
    Color? ledColor,
    int? ledOnMs,
    int? ledOffMs,
    String? ticker,
    NotificationVisibility? visibility,
    int? timeoutAfter,
    AndroidNotificationCategory? category,
    DidReceiveNotificationResponseCallback? onSelectNotification,
    bool? requestAlertPermission,
    bool? requestSoundPermission,
    bool? requestBadgePermission,
    bool? defaultPresentAlert,
    bool? defaultPresentSound,
    bool? defaultPresentBadge,
    DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification,
    bool? presentAlert,
    bool? presentSound,
    bool? presentBadge,
    String? soundFile,
    int? badgeNumber,
  }) async {
    // No need to continue.
    if (_init) return _init;

    if (appIcon != null && appIcon.trim().isEmpty) appIcon = null;
    appIcon ??= _appIcon;
    // init parameters take over initial parameter values.
    if (schedule != null) _schedule = schedule;
    if (title != null) _title = title;
    if (body != null) _body = body;
    if (payload != null) _payload = payload;
    if (androidAllowWhileIdle != null)
      _androidAllowWhileIdle = androidAllowWhileIdle;
    if (icon != null) _icon = icon;
    if (importance != null) _importance = importance;
    if (priority != null) _priority = priority;
    if (styleInformation != null) _styleInformation = styleInformation;
    if (playSound != null) _playSound = playSound;
    if (sound != null) _sound = sound;
    if (enableVibration != null) _enableVibration = enableVibration;
    if (vibrationPattern != null) _vibrationPattern = vibrationPattern;
    if (groupKey != null) _groupKey = groupKey;
    if (setAsGroupSummary != null) _setAsGroupSummary = setAsGroupSummary;
    if (groupAlertBehavior != null) _groupAlertBehavior = groupAlertBehavior;
    if (autoCancel != null) _autoCancel = autoCancel;
    if (ongoing != null) _ongoing = ongoing;
    if (color != null) _color = color;
    if (largeIcon != null) _largeIcon = largeIcon;
    if (onlyAlertOnce != null) _onlyAlertOnce = onlyAlertOnce;
    if (showWhen != null) _showWhen = showWhen;
    if (channelShowBadge != null) _channelShowBadge = channelShowBadge;
    if (showProgress != null) _showProgress = showProgress;
    if (maxProgress != null) _maxProgress = maxProgress;
    if (progress != null) _progress = progress;
    if (indeterminate != null) _indeterminate = indeterminate;
    if (channelAction != null) _channelAction = channelAction;
    if (enableLights != null) _enableLights = enableLights;
    if (ledColor != null) _ledColor = ledColor;
    if (ledOnMs != null) _ledOnMs = ledOnMs;
    if (ledOffMs != null) _ledOffMs = ledOffMs;
    if (ticker != null) _ticker = ticker;
    if (visibility != null) _visibility = visibility;
    if (timeoutAfter != null) _timeoutAfter = timeoutAfter;
    if (category != null) _category = category;
    onSelectNotification ??= _selectNotificationCallback;
    requestAlertPermission ??= _requestAlertPermission;
    requestSoundPermission ??= _requestSoundPermission;
    requestBadgePermission ??= _requestBadgePermission;
    defaultPresentAlert ??= _defaultPresentAlert;
    defaultPresentSound ??= _defaultPresentSound;
    defaultPresentBadge ??= _defaultPresentBadge;
    onDidReceiveLocalNotification ??= _onDidReceiveLocalNotification;
    if (presentAlert != null) _presentAlert = presentAlert;
    if (presentSound != null) _presentSound = presentSound;
    if (presentBadge != null) _presentBadge = presentBadge;
    if (soundFile != null) _soundFile = soundFile;
    if (badgeNumber != null) _badgeNumber = badgeNumber;

    //
    try {
      var initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings(_appIcon ?? ""),
      );

      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      _init = (await _flutterLocalNotificationsPlugin!.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: onSelectNotification))!;
    } catch (ex) {
      getError(ex);
      _init = false;
    }

    return _init;
  }

  @mustCallSuper
  void dispose() {
    // Not really necessary but provides a dispose() function for the user.
    _flutterLocalNotificationsPlugin = null;
  }

  // plugin
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  bool _init = false;
  bool get initialized => _init;

  int? show({
    int? id,
    String? title,
    String? body,
    String? payload,
    bool? androidAllowWhileIdle,
    String? icon,
    Importance? importance,
    Priority? priority,
    StyleInformation? styleInformation,
    bool? playSound = true,
    AndroidNotificationSound? sound,
    bool? enableVibration,
    List<int>? vibrationPattern,
    String? groupKey,
    bool? setAsGroupSummary,
    GroupAlertBehavior? groupAlertBehavior,
    bool? autoCancel,
    bool? ongoing,
    Color? color,
    AndroidBitmap? largeIcon,
    bool? onlyAlertOnce,
    bool? showWhen,
    bool? channelShowBadge,
    bool? showProgress,
    int? maxProgress,
    int? progress,
    bool? indeterminate,
    AndroidNotificationChannelAction? channelAction,
    bool? enableLights,
    Color? ledColor,
    int? ledOnMs,
    int? ledOffMs,
    String? ticker,
    NotificationVisibility? visibility,
    int? timeoutAfter,
    AndroidNotificationCategory? category,
    bool? presentAlert,
    bool? presentSound,
    bool? presentBadge,
    String? soundFile,
    int? badgeNumber,
  }) {
    //
    var notificationSpecifics = _notificationDetails(
      title,
      body,
      payload,
      androidAllowWhileIdle,
      icon,
      importance,
      priority,
      styleInformation,
      playSound,
      sound,
      enableVibration,
      vibrationPattern,
      groupKey,
      setAsGroupSummary,
      groupAlertBehavior,
      autoCancel,
      ongoing,
      color,
      largeIcon,
      onlyAlertOnce,
      showWhen,
      channelShowBadge,
      showProgress,
      maxProgress,
      progress,
      indeterminate,
      channelAction,
      enableLights,
      ledColor,
      ledOnMs,
      ledOffMs,
      ticker,
      visibility,
      timeoutAfter,
      category,
      presentAlert,
      presentSound,
      presentBadge,
      soundFile,
      badgeNumber,
    );

    if (notificationSpecifics == null) {
      id = -1;
    } else {
      //
      try {
        //
        if (id == null || id < 0) id = Random().nextInt(999);

        _flutterLocalNotificationsPlugin!.show(
          id,
          title,
          body,
          notificationSpecifics,
          payload: payload,
        );
      } catch (ex) {
        id = -1;
        getError(ex);
      }
    }
    return id;
  }

  NotificationDetails? _notificationDetails(
    String? title,
    String? body,
    String? payload,
    bool? androidAllowWhileIdle,
    String? icon,
    Importance? importance,
    Priority? priority,
    StyleInformation? styleInformation,
    bool? playSound,
    AndroidNotificationSound? sound,
    bool? enableVibration,
    List<int>? vibrationPattern,
    String? groupKey,
    bool? setAsGroupSummary,
    GroupAlertBehavior? groupAlertBehavior,
    bool? autoCancel,
    bool? ongoing,
    Color? color,
    AndroidBitmap? largeIcon,
    bool? onlyAlertOnce,
    bool? showWhen,
    bool? channelShowBadge,
    bool? showProgress,
    int? maxProgress,
    int? progress,
    bool? indeterminate,
    AndroidNotificationChannelAction? channelAction,
    bool? enableLights,
    Color? ledColor,
    int? ledOnMs,
    int? ledOffMs,
    String? ticker,
    NotificationVisibility? visibility,
    int? timeoutAfter,
    AndroidNotificationCategory? category,
    bool? presentAlert,
    bool? presentSound,
    bool? presentBadge,
    String? soundFile,
    int? badgeNumber,
  ) {
    //
    NotificationDetails? notificationSpecifics = null;

    // Failed to initialized.
    if (!_init) {
      if (hasError) {
        assert(false, errorMsg);
      } else {
        assert(false, 'ScheduleNotifications: Failed to call init() first!');
      }
      return notificationSpecifics;
    }

    title ??= _title;
    body ??= _body;
    payload ??= _payload;
    androidAllowWhileIdle ??= _androidAllowWhileIdle;
    icon ??= _icon;
    importance ??= _importance;
    priority ??= _priority;
    styleInformation ??= _styleInformation;
    playSound ??= _playSound;
    sound ??= _sound;
    enableVibration ??= _enableVibration;
    vibrationPattern ??= _vibrationPattern;
    groupKey ??= _groupKey;
    setAsGroupSummary ??= _setAsGroupSummary;
    groupAlertBehavior ??= _groupAlertBehavior;
    autoCancel ??= _autoCancel;
    ongoing ??= _ongoing;
    color ??= _color;
    largeIcon ??= _largeIcon;
    onlyAlertOnce ??= _onlyAlertOnce;
    showWhen ??= _showWhen;
    channelShowBadge ??= _channelShowBadge;
    showProgress ??= _showProgress;
    maxProgress ??= _maxProgress;
    progress ??= _progress;
    indeterminate ??= _indeterminate;
    channelAction ??= _channelAction;
    enableLights ??= _enableLights;
    ledColor ??= _ledColor;
    ledOnMs ??= _ledOnMs;
    ledOffMs ??= _ledOffMs;
    ticker ??= _ticker;
    visibility ??= _visibility;
    timeoutAfter ??= _timeoutAfter;
    category ??= _category;
    presentAlert ??= _presentAlert;
    presentSound ??= _presentSound;
    presentBadge ??= _presentBadge;
    soundFile ??= _soundFile;
    badgeNumber ??= _badgeNumber;

    // Play the sound if supplied a sound.
    if (playSound == null && sound != null) playSound = true;

    // If to vibrate then do so.
    if (enableVibration != null &&
        enableVibration &&
        (vibrationPattern == null || vibrationPattern.isEmpty)) {
      vibrationPattern = Int64List(4);
      vibrationPattern[0] = 0;
      vibrationPattern[1] = 1000;
      vibrationPattern[2] = 5000;
      vibrationPattern[3] = 2000;
    }

    AndroidNotificationDetails androidSettings;

    try {
      androidSettings = AndroidNotificationDetails(
        channelId ?? "",
        channelName ?? "",
        channelDescription: channelDescription ?? "",
        icon: icon,
        importance: importance ?? Importance.defaultImportance,
        priority: priority ?? Priority.defaultPriority,
        styleInformation: styleInformation,
        playSound: playSound ?? true,
        sound: sound,
        enableVibration: enableVibration ?? true,
        // vibrationPattern: vibrationPattern,
        groupKey: groupKey,
        setAsGroupSummary: setAsGroupSummary ?? false,
        groupAlertBehavior: groupAlertBehavior ?? GroupAlertBehavior.all,
        autoCancel: autoCancel ?? false,
        ongoing: ongoing ?? false,
        color: color,
        onlyAlertOnce: onlyAlertOnce ?? true,
        showWhen: showWhen ?? true,
        channelShowBadge: channelShowBadge ?? true,
        showProgress: showProgress ?? false,
        maxProgress: maxProgress ?? 0,
        progress: progress ?? 0,
        indeterminate: indeterminate ?? true,
        channelAction:
            channelAction ?? AndroidNotificationChannelAction.createIfNotExists,
        enableLights: enableLights ?? true,
        ledColor: ledColor,
        ledOnMs: ledOnMs,
        ledOffMs: ledOffMs,
        ticker: ticker,
        visibility: visibility,
        timeoutAfter: timeoutAfter,
        category: category,
      );
    } catch (ex) {
      getError(ex);
      return notificationSpecifics;
    }

    try {
      notificationSpecifics = NotificationDetails(android: androidSettings);
    } catch (ex) {
      notificationSpecifics = null;
      getError(ex);
    }
    return notificationSpecifics;
  }

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() =>
      _flutterLocalNotificationsPlugin!.getNotificationAppLaunchDetails();
}

mixin HandleError {
  /// Return the 'last' error if any.
  Exception? getError([dynamic error]) {
    var ex = _error;
    if (error == null) {
      _error = null;
    } else {
      if (error is! Exception) {
        _error = Exception(error.toString());
      } else {
        _error = error;
      }
      ex ??= _error;
    }
    return ex;
  }

  /// Simply display the error.
  String? get errorMsg => _error == null ? '' : _error.toString();

  /// Determine if app is 'in error.'
  bool get inError => _error != null;
  bool get hasError => _error != null;
  Exception? _error;
}
