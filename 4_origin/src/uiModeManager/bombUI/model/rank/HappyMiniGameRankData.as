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
      
      public function HappyMiniGameRankData(serverName:String, playerName:String, score:int)
      {
         super();
         this._serverName = serverName;
         this._playerName = playerName;
         this._score = score;
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
         var data:* = null;
         var cfg:RankRewardCfg = HappyLittleGameManager.instance.rankRewardCfg;
         if(!cfg.aviliable)
         {
            return null;
         }
         var id:* = uint(0);
         var _loc6_:int = 0;
         var _loc5_:* = cfg.cfg;
         for(var key in cfg.cfg)
         {
            data = cfg.cfg[key];
            if(rank + 1 <= data.RankMax && rank + 1 >= data.RankMin)
            {
               id = key;
            }
         }
         return ItemManager.Instance.getTemplateById(id);
      }
   }
}
