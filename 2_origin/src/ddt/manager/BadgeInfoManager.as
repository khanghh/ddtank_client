package ddt.manager
{
   import consortion.data.BadgeInfo;
   import ddt.data.analyze.BadgeInfoAnalyzer;
   import flash.utils.Dictionary;
   
   public class BadgeInfoManager
   {
      
      private static var _instance:BadgeInfoManager;
       
      
      private var _badgeList:Dictionary;
      
      public function BadgeInfoManager()
      {
         super();
         _badgeList = new Dictionary();
      }
      
      public static function get instance() : BadgeInfoManager
      {
         if(_instance == null)
         {
            _instance = new BadgeInfoManager();
         }
         return _instance;
      }
      
      public function setup(param1:BadgeInfoAnalyzer) : void
      {
         _badgeList = param1.list;
      }
      
      public function getBadgeInfoByID(param1:int) : BadgeInfo
      {
         return _badgeList[param1];
      }
      
      public function getBadgeInfoByLevel(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _badgeList;
         for each(var _loc4_ in _badgeList)
         {
            if(_loc4_.LimitLevel >= param1 && _loc4_.LimitLevel <= param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }
}
