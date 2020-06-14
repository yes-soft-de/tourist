import 'package:inject/inject.dart';
import 'package:tourists/main.dart';
import 'package:tourists/network/http_client/http_client.dart';

import 'app.component.inject.dart' as g;

@Injector()
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create() async {
    return await g.AppComponent$Injector.create(
    );
  }

  @provide
  HttpClient getHttpClient();
}