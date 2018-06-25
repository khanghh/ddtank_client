package ddt.manager{   import consortion.data.BadgeInfo;   import ddt.data.analyze.BadgeInfoAnalyzer;   import flash.utils.Dictionary;      public class BadgeInfoManager   {            private static var _instance:BadgeInfoManager;                   private var _badgeList:Dictionary;            public function BadgeInfoManager() { super(); }
            public static function get instance() : BadgeInfoManager { return null; }
            public function setup(analyzer:BadgeInfoAnalyzer) : void { }
            public function getBadgeInfoByID(id:int) : BadgeInfo { return null; }
            public function getBadgeInfoByLevel(min:int, max:int) : Array { return null; }
   }}