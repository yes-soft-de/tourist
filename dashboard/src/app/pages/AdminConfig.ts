export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  public static sourceAPI                   = 'http://turkey-app.yes-cloud.de/html/public/index.php/';
  // public static sourceAPI                   = 'http://tourist.yes-cloud.de//html/public/index.php/';
  // public static sourceAPI                   = 'http://localhost:8000/';

  // All Application Api
  public static loginAPI                    = AdminConfig.sourceAPI + 'login_check';
  public static userAPI                     = AdminConfig.sourceAPI + 'user';

  // Regions
  public static regionsAPI                  = AdminConfig.sourceAPI + 'regions';
  public static regionAPI                   = AdminConfig.sourceAPI + 'region';

  // Events
  public static eventsAPI                  = AdminConfig.sourceAPI + 'events';
  public static eventAPI                   = AdminConfig.sourceAPI + 'event';


  // Upload
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile';
}
