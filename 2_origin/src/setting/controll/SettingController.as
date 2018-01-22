package setting.controll
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.manager.SharedManager;
   
   public class SettingController extends CoreManager
   {
      
      private static var _instance:SettingController;
      
      public static const CLOSE_VIEW:String = "closeview";
       
      
      private var _isShow:Boolean;
      
      public function SettingController()
      {
         super();
      }
      
      public static function get Instance() : SettingController
      {
         if(!_instance)
         {
            _instance = new SettingController();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("openview"));
      }
      
      public function switchVisible() : void
      {
         if(isShow)
         {
            hide();
         }
         else
         {
            show();
         }
      }
      
      public function showSetingView() : void
      {
         if(!SharedManager.Instance.isSetingMovieClip)
         {
            return;
         }
         show();
      }
      
      public function hide() : void
      {
         dispatchEvent(new CEvent("closeview"));
      }
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
   }
}
