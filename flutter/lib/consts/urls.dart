class Urls {
  static String baseAPI = 'http://tourist.yes-cloud.de/html/public/index.php/';
  static final imagesRoot = 'http://tourist.yes-cloud.de/upload/';

  static final loginAPI = 'login_check';
  static final loginGuideAPI = 'guide';
  static final loginTouristsAPI = 'tourist';
  static final registerGuideAPI = 'guide';
  static final registerTouristsAPI = 'tourist';
  static final uploadAPI = 'upload';
  static final createProfileAPI = 'tourist';
  static final getTouristProfileAPI = 'tourist';
  static final getGuideProfile = 'guide';

  static final locationList = 'regions';
  static final locationDetails = 'regionbyplaceid/';
  static final createLocationDetails = 'region';
  static final guideList = 'guides';
  static final guidesByRegion = 'guide';
  static final orderGuide = 'order';
  static final orderLookup = 'orderlookup';
  static final acceptOrder = 'acceptorder';
  static final updateOrder = 'order';
  static final touristOrders = 'orders';
  static final guideOrders = 'guidorder';
  static final comment = 'comment';
  static final event = 'event';
  static final eventList = 'events';
  static final rate = 'rating';
  static final mapHelper = 'maphelper';
  static final googleAutoComplete =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static final googlePlaceDetails =
      'https://maps.googleapis.com/maps/api/place/details/json';

  static final CREATE_TOKEN_API = 'login_check';
}
