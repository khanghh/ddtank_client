package ddt.manager
{
   import flash.events.EventDispatcher;
   
   public class ConsortiaDutyManager extends EventDispatcher
   {
      
      private static var _instance:ConsortiaDutyManager;
       
      
      public function ConsortiaDutyManager()
      {
         super();
      }
      
      public static function GetRight(right:int, consortiaDutyType:int) : Boolean
      {
         return (right & int(consortiaDutyType)) != 0;
      }
      
      public static function get Instance() : ConsortiaDutyManager
      {
         if(_instance == null)
         {
            _instance = new ConsortiaDutyManager();
         }
         return _instance;
      }
   }
}
