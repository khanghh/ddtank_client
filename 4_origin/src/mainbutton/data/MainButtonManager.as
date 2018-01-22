package mainbutton.data
{
   import flash.utils.Dictionary;
   import mainbutton.MainButton;
   
   public class MainButtonManager
   {
      
      private static var _instance:MainButtonManager;
       
      
      private var _HallIconList:Dictionary;
      
      public function MainButtonManager()
      {
         super();
      }
      
      public static function get instance() : MainButtonManager
      {
         if(_instance == null)
         {
            _instance = new MainButtonManager();
         }
         return _instance;
      }
      
      public function gethallIconInfo(param1:HallIconDataAnalyz) : void
      {
         _HallIconList = param1.list;
      }
      
      public function getInfoByID(param1:String) : MainButton
      {
         return _HallIconList[param1];
      }
   }
}
