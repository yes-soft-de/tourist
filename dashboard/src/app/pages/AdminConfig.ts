export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  public static sourceAPI                   = 'http://turkey-app.yes-cloud.de/html/public/index.php/';
  // public static sourceAPI                   = 'http://tourist.yes-cloud.de//html/public/index.php/';
  // public static sourceAPI                   = 'http://localhost:8000/';

  // All Application Api
  public static loginAPI                    = AdminConfig.sourceAPI + 'login_check';
  public static userAPI                     = AdminConfig.sourceAPI + 'user';

  // Chats
  public static chatsAPI                    = AdminConfig.sourceAPI + 'getallchat';


  // Upload
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile';
}
