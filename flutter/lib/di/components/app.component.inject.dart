import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../network/http_client/http_client.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../guide_authorization_module/guide_authorization_module.dart'
    as _i6;
import '../../guide_authorization_module/ui/screens/guide_profile/guide_profile.dart'
    as _i7;
import '../../locations_module/service/location_list/location_list_service.dart'
    as _i8;
import '../../locations_module/manager/location_list/location_list_manager.dart'
    as _i9;
import '../../locations_module/repository/location_list/location_list_repository.dart'
    as _i10;
import '../../guide_authorization_module/bloc/guide_register/guide_register.dart'
    as _i11;
import '../../guide_authorization_module/ui/screens/guide_login/guide_login.dart'
    as _i12;
import '../../guide_authorization_module/bloc/guide_login/guide_login.bloc.dart'
    as _i13;
import '../../guide_home_module/guide_module.dart' as _i14;
import '../../guide_home_module/ui/screens/guide_home/guide_home.dart' as _i15;
import '../../guide_home_module/ui/screens/guide_home/subscreens/main/guide_main_subscreen.dart'
    as _i16;
import '../../guide_home_module/bloc/guide_home/guide_home.dart' as _i17;
import '../../services/orders/orders_service.dart' as _i18;
import '../../managers/orders/orders_manager.dart' as _i19;
import '../../repositories/orders/orders.dart' as _i20;
import '../../services/guide_list/guide_list.dart' as _i21;
import '../../managers/guides_manager/guides_manager.dart' as _i22;
import '../../repositories/guides/guide_repository.dart' as _i23;
import '../../locations_module/location_module.dart' as _i24;
import '../../locations_module/ui/screens/location_details/location_details.dart'
    as _i25;
import '../../locations_module/bloc/location_details/location_details_bloc.dart'
    as _i26;
import '../../locations_module/service/location_details/location_details_service.dart'
    as _i27;
import '../../locations_module/manager/location_details/location_details.dart'
    as _i28;
import '../../locations_module/repository/location_details/location_details_repository.dart'
    as _i29;
import '../../managers/rate/rate_manager.dart' as _i30;
import '../../repositories/rating/rating_repository.dart' as _i31;
import '../../persistence/sharedpref/shared_preferences_helper.dart' as _i32;
import '../../managers/comment/comment_service.dart' as _i33;
import '../../repositories/comment/comment_repository.dart' as _i34;
import '../../locations_module/ui/screens/event_details/event_details_screen.dart'
    as _i35;
import '../../locations_module/bloc/event_details/event_details.dart' as _i36;
import '../../services/event/event_service.dart' as _i37;
import '../../managers/event/event_manager.dart' as _i38;
import '../../repositories/event/event_repository.dart' as _i39;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.HttpClient _singletonHttpClient;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(null, _createGuideAuthorizationModule(),
      null, _createGuideHomeModule(), _createLocationModule());
  _i6.GuideAuthorizationModule _createGuideAuthorizationModule() =>
      _i6.GuideAuthorizationModule(
          _createGuideProfileScreen(), _createGuideLoginScreen());
  _i7.GuideProfileScreen _createGuideProfileScreen() => _i7.GuideProfileScreen(
      _createLocationListService(), _createGuideRegisterBloc());
  _i8.LocationListService _createLocationListService() =>
      _i8.LocationListService(_createLocationListManager());
  _i9.LocationListManager _createLocationListManager() =>
      _i9.LocationListManager(_createLocationListRepository());
  _i10.LocationListRepository _createLocationListRepository() =>
      _i10.LocationListRepository(_createHttpClient());
  _i3.HttpClient _createHttpClient() =>
      _singletonHttpClient ??= _i3.HttpClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i11.GuideRegisterBloc _createGuideRegisterBloc() =>
      _i11.GuideRegisterBloc(null);
  _i12.GuideLoginScreen _createGuideLoginScreen() =>
      _i12.GuideLoginScreen(_createGuideLoginBloc());
  _i13.GuideLoginBloc _createGuideLoginBloc() => _i13.GuideLoginBloc();
  _i14.GuideHomeModule _createGuideHomeModule() =>
      _i14.GuideHomeModule(_createGuideHomeScreen());
  _i15.GuideHomeScreen _createGuideHomeScreen() =>
      _i15.GuideHomeScreen(_createGuideMainSubScreen());
  _i16.GuideMainSubScreen _createGuideMainSubScreen() =>
      _i16.GuideMainSubScreen(_createGuideHomeBloc());
  _i17.GuideHomeBloc _createGuideHomeBloc() =>
      _i17.GuideHomeBloc(_createOrdersService());
  _i18.OrdersService _createOrdersService() =>
      _i18.OrdersService(_createOrdersManager(), _createGuideListService());
  _i19.OrdersManager _createOrdersManager() =>
      _i19.OrdersManager(_createOrdersRepository());
  _i20.OrdersRepository _createOrdersRepository() =>
      _i20.OrdersRepository(_createHttpClient());
  _i21.GuideListService _createGuideListService() =>
      _i21.GuideListService(_createGuidesManager());
  _i22.GuidesManager _createGuidesManager() =>
      _i22.GuidesManager(_createGuidesRepository());
  _i23.GuidesRepository _createGuidesRepository() =>
      _i23.GuidesRepository(_createHttpClient());
  _i24.LocationModule _createLocationModule() => _i24.LocationModule(
      _createLocationDetailsScreen(), _createEventDetailsScreen());
  _i25.LocationDetailsScreen _createLocationDetailsScreen() =>
      _i25.LocationDetailsScreen(_createLocationDetailsBloc());
  _i26.LocationDetailsBloc _createLocationDetailsBloc() =>
      _i26.LocationDetailsBloc(_createLocationDetailsService(),
          _createSharedPreferencesHelper(), _createCommentManager());
  _i27.LocationDetailsService _createLocationDetailsService() =>
      _i27.LocationDetailsService(
          _createLocationDetailsManager(),
          _createGuidesManager(),
          _createRatingManager(),
          _createSharedPreferencesHelper());
  _i28.LocationDetailsManager _createLocationDetailsManager() =>
      _i28.LocationDetailsManager(_createLocationDetailsRepository());
  _i29.LocationDetailsRepository _createLocationDetailsRepository() =>
      _i29.LocationDetailsRepository(_createHttpClient());
  _i30.RatingManager _createRatingManager() =>
      _i30.RatingManager(_createRatingRepository());
  _i31.RatingRepository _createRatingRepository() =>
      _i31.RatingRepository(_createHttpClient());
  _i32.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i32.SharedPreferencesHelper();
  _i33.CommentManager _createCommentManager() =>
      _i33.CommentManager(_createCommentRepository());
  _i34.CommentRepository _createCommentRepository() =>
      _i34.CommentRepository(_createHttpClient());
  _i35.EventDetailsScreen _createEventDetailsScreen() =>
      _i35.EventDetailsScreen(_createEventDetailsBloc());
  _i36.EventDetailsBloc _createEventDetailsBloc() => _i36.EventDetailsBloc(
      _createEventService(), _createLocationListService());
  _i37.EventService _createEventService() =>
      _i37.EventService(_createEventManager());
  _i38.EventManager _createEventManager() =>
      _i38.EventManager(_createEventRepository());
  _i39.EventRepository _createEventRepository() =>
      _i39.EventRepository(_createHttpClient());
  @override
  _i5.MyApp get app => _createMyApp();
}
