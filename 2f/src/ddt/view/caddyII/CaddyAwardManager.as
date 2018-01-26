package ddt.view.caddyII
{
   public class CaddyAwardManager
   {
      
      private static var _instance:CaddyAwardManager;
       
      
      public var _awards:Vector.<CaddyAwardInfo>;
      
      public var _silverAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldAwards:Vector.<CaddyAwardInfo>;
      
      public function CaddyAwardManager(){super();}
      
      public static function get Instance() : CaddyAwardManager{return null;}
      
      public function completeHander(param1:CaddyAwardDataAnalyzer) : void{}
   }
}
