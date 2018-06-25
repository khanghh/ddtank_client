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
      
      public function gethallIconInfo(analyzer:HallIconDataAnalyz) : void
      {
         _HallIconList = analyzer.list;
      }
      
      public function getInfoByID(key:String) : MainButton
      {
         return _HallIconList[key];
      }
   }
}
