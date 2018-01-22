package uiModeManager.bombUI.model.rank
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public final class HappyMiniGameRankData
   {
       
      
      public var rank:uint;
      
      private var _playerName:String;
      
      private var _serverName:String;
      
      private var _score:int;
      
      public function HappyMiniGameRankData(param1:String, param2:String, param3:int)
      {
         super();
         this._serverName = param1;
         this._playerName = param2;
         this._score = param3;
      }
      
      public function get playerName() : String
      {
         return this._playerName;
      }
      
      public function get serverName() : String
      {
         return this._serverName;
      }
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function get itemInfo() : ItemTemplateInfo
      {
         var _loc2_:* = null;
         var _loc3_:RankRewardCfg = HappyLittleGameManager.instance.rankRewardCfg;
         if(!_loc3_.aviliable)
         {
            return null;
         }
         var _loc1_:* = uint(0);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_.cfg;
         for(var _loc4_ in _loc3_.cfg)
         {
            _loc2_ = _loc3_.cfg[_loc4_];
            if(rank + 1 <= _loc2_.RankMax && rank + 1 >= _loc2_.RankMin)
            {
               _loc1_ = _loc4_;
            }
         }
         return ItemManager.Instance.getTemplateById(_loc1_);
      }
   }
}
