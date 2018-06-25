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
      
      public function setup(analyzer:BadgeInfoAnalyzer) : void
      {
         _badgeList = analyzer.list;
      }
      
      public function getBadgeInfoByID(id:int) : BadgeInfo
      {
         return _badgeList[id];
      }
      
      public function getBadgeInfoByLevel(min:int, max:int) : Array
      {
         var result:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _badgeList;
         for each(var info in _badgeList)
         {
            if(info.LimitLevel >= min && info.LimitLevel <= max)
            {
               result.push(info);
            }
         }
         return result;
      }
   }
}
