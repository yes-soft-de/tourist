class Urls {
  static String baseAPI = 'http://tourist.yes-cloud.de/html/public/index.php/';
  static final imagesRoot = 'http://tourist.yes-cloud.de/upload/';

  static final loginAPI = baseAPI + 'login_check';
  static final loginGuideAPI = baseAPI + 'guid';
  static final loginTouristsAPI = baseAPI + 'tourist';
  static final registerGuideAPI = baseAPI + 'guid';
  static final registerTouristsAPI = baseAPI + 'tourist';
  static final uploadAPI = baseAPI + 'upload';
  static final createProfileAPI = baseAPI + 'tourist';
  static final getTouristProfileAPI = baseAPI + 'tourist';
  static final locationList = baseAPI + 'regions';
  static final locationDetails = baseAPI + 'region/';
  static final createLocationDetails = baseAPI + 'region';
  static final guideList = baseAPI + 'guides';
  static final guidesByRegion = baseAPI + 'guid';
  static final orderGuide = baseAPI + 'order';
  static final orderLookup = baseAPI + 'orderlookup';
  static final acceptOrder = baseAPI + 'acceptorder';
  static final updateOrder = baseAPI + 'order';
  static final guideOrders = baseAPI + 'guidorder';
  static final comment = baseAPI + 'comment';
  static final event = baseAPI + 'event';
  static final rate = baseAPI + 'rating';
  static final mapHelper = baseAPI + 'maphelper';
  static final googleAutoComplete = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static final googlePlaceDetails = 'https://maps.googleapis.com/maps/api/place/details/json';

  static final CREATE_TOKEN_API = baseAPI + 'login_check';
}
