import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:inject/inject.dart';

@provide
@singleton
class Logger {
  void info(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void warn(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void error(String tag, String msg, [StackTrace trace]) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
    FirebaseCrashlytics.instance.recordError('$tag $msg', trace ?? StackTrace.empty);
    FirebaseCrashlytics.instance.sendUnsentReports();
  }
}
