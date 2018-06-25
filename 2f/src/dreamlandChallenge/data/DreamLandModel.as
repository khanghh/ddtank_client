package dreamlandChallenge.data{   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;      public class DreamLandModel extends EventDispatcher   {            public static const REFRESH_RANKING:String = "refreshRanking";            public static const UPDATE_DCCOUT:String = "updateChallengeCount";            public static const SELF_POINT_UPDATE:String = "selfPointUpdate";                   private var _selfPoint:int;            private var _selfTotalPoint:int;            private var _surplusCount:int;            private var _rankModel:DCSpeedMatchRankMode;            private var _selfRankInfo:DictionaryData;            public function DreamLandModel() { super(); }
            public function get selfTotalPoint() : int { return 0; }
            public function set selfTotalPoint(value:int) : void { }
            public function get selfRankInfo() : DictionaryData { return null; }
            public function addSelfRandItem(item:DreamLandSelfRankVo) : void { }
            public function getSelfRankItemByType(type:int) : DreamLandSelfRankVo { return null; }
            public function get rankModel() : DCSpeedMatchRankMode { return null; }
            public function set rankModel(value:DCSpeedMatchRankMode) : void { }
            public function get surplusCount() : int { return 0; }
            public function set surplusCount(value:int) : void { }
            public function get selfPoint() : int { return 0; }
            public function set selfPoint(value:int) : void { }
   }}