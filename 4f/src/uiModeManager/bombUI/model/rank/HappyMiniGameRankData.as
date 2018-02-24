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
      
      public function HappyMiniGameRankData(param1:String, param2:String, param3:int){super();}
      
      public function get playerName() : String{return null;}
      
      public function get serverName() : String{return null;}
      
      public function get score() : int{return 0;}
      
      public function get itemInfo() : ItemTemplateInfo{return null;}
   }
}
