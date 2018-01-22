package ddt.view.caddyII
{
   public class CaddyAwardManager
   {
      
      private static var _instance:CaddyAwardManager;
       
      
      public var _awards:Vector.<CaddyAwardInfo>;
      
      public var _silverAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldAwards:Vector.<CaddyAwardInfo>;
      
      public function CaddyAwardManager()
      {
         super();
      }
      
      public static function get Instance() : CaddyAwardManager
      {
         if(!_instance)
         {
            _instance = new CaddyAwardManager();
         }
         return _instance;
      }
      
      public function completeHander(param1:CaddyAwardDataAnalyzer) : void
      {
         _awards = param1._awards;
         _silverAwards = param1._silverAwards;
         _goldAwards = param1._goldAwards;
      }
   }
}
