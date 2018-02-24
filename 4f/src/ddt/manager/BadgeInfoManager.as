package ddt.manager
{
   import consortion.data.BadgeInfo;
   import ddt.data.analyze.BadgeInfoAnalyzer;
   import flash.utils.Dictionary;
   
   public class BadgeInfoManager
   {
      
      private static var _instance:BadgeInfoManager;
       
      
      private var _badgeList:Dictionary;
      
      public function BadgeInfoManager(){super();}
      
      public static function get instance() : BadgeInfoManager{return null;}
      
      public function setup(param1:BadgeInfoAnalyzer) : void{}
      
      public function getBadgeInfoByID(param1:int) : BadgeInfo{return null;}
      
      public function getBadgeInfoByLevel(param1:int, param2:int) : Array{return null;}
   }
}
