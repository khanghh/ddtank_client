package dreamlandChallenge.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class DreamLandModel extends EventDispatcher
   {
      
      public static const REFRESH_RANKING:String = "refreshRanking";
      
      public static const UPDATE_DCCOUT:String = "updateChallengeCount";
      
      public static const SELF_POINT_UPDATE:String = "selfPointUpdate";
       
      
      private var _selfPoint:int;
      
      private var _selfTotalPoint:int;
      
      private var _surplusCount:int;
      
      private var _rankModel:DCSpeedMatchRankMode;
      
      private var _selfRankInfo:DictionaryData;
      
      public function DreamLandModel()
      {
         super();
         _selfRankInfo = new DictionaryData();
      }
      
      public function get selfTotalPoint() : int
      {
         return _selfTotalPoint;
      }
      
      public function set selfTotalPoint(value:int) : void
      {
         _selfTotalPoint = value;
      }
      
      public function get selfRankInfo() : DictionaryData
      {
         return _selfRankInfo;
      }
      
      public function addSelfRandItem(item:DreamLandSelfRankVo) : void
      {
         if(_selfRankInfo != null)
         {
            _selfRankInfo[item.difficultyType] = item;
         }
      }
      
      public function getSelfRankItemByType(type:int) : DreamLandSelfRankVo
      {
         if(_selfRankInfo && _selfRankInfo.hasKey(type))
         {
            return _selfRankInfo[type];
         }
         return new DreamLandSelfRankVo();
      }
      
      public function get rankModel() : DCSpeedMatchRankMode
      {
         return _rankModel;
      }
      
      public function set rankModel(value:DCSpeedMatchRankMode) : void
      {
         if(_rankModel)
         {
            _rankModel.clear();
         }
         _rankModel = value;
         this.dispatchEvent(new Event("refreshRanking"));
      }
      
      public function get surplusCount() : int
      {
         return _surplusCount;
      }
      
      public function set surplusCount(value:int) : void
      {
         _surplusCount = value;
         this.dispatchEvent(new Event("updateChallengeCount"));
      }
      
      public function get selfPoint() : int
      {
         return _selfPoint;
      }
      
      public function set selfPoint(value:int) : void
      {
         _selfPoint = value;
         this.dispatchEvent(new Event("selfPointUpdate"));
      }
   }
}
