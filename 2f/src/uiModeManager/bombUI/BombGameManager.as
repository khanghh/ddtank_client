package uiModeManager.bombUI
{
   import ddt.data.player.SelfInfo;
   import ddt.manager.PlayerManager;
   import flash.display.MovieClip;
   import funnyGames.cubeGame.CubeGameManager;
   import road7th.data.DictionaryData;
   import road7th.utils.StringHelper;
   import uiModeManager.bombUI.model.bomb.BombGameModel;
   import uiModeManager.bombUI.model.bomb.BombGameRandomMapAnalyzer;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   import uiModeManager.bombUI.model.bomb.FixedMapData;
   import uiModeManager.bombUI.model.bomb.RandomMapData;
   
   public class BombGameManager
   {
       
      
      private var bombPool:Array;
      
      private var explode:MovieClip;
      
      private var bullet:MovieClip;
      
      private var _model:BombGameModel;
      
      private var _fixedData:DictionaryData;
      
      private var _randomData:DictionaryData;
      
      public var currentGameLv:int = 1;
      
      public var doubleScore:Boolean = false;
      
      public function BombGameManager(){super();}
      
      public function get model() : BombGameModel{return null;}
      
      public function clearBombData() : void{}
      
      public function initTotalRankData(param1:BombRankInfo, param2:int) : void{}
      
      public function clearRankDataByType(param1:int) : void{}
      
      public function initDayRankData(param1:BombRankInfo, param2:int) : void{}
      
      public function FixedAnalyzer(param1:BombGameFixedMapAnalyzer) : void{}
      
      public function RandomAnalyzer(param1:BombGameRandomMapAnalyzer) : void{}
      
      public function get Fixeddata() : DictionaryData{return null;}
      
      public function get Randomdata() : DictionaryData{return null;}
      
      public function CurrentRandomMapinfos(param1:int) : Array{return null;}
      
      public function getRandomMapData(param1:RandomMapData) : Array{return null;}
      
      private function PutElementInData(param1:Array, param2:Array, param3:int, param4:int) : void{}
      
      private function randRange(param1:Number, param2:Number) : Number{return 0;}
      
      public function GetRandomMapDataByLv(param1:int) : RandomMapData{return null;}
      
      public function CheckCurrentLvBound(param1:int) : Boolean{return false;}
      
      public function CurrentBombGameRankInfo(param1:int) : Vector.<BombRankInfo>{return null;}
      
      public function GetFixedMapDataByLv(param1:int) : FixedMapData{return null;}
      
      public function GetCurrentBombMapData() : Array{return null;}
      
      public function CurrentFixedMapInfos(param1:int) : Array{return null;}
      
      private function getFixedMapData(param1:FixedMapData) : Array{return null;}
      
      public function getMyTotalRankByGameType(param1:int) : int{return 0;}
      
      public function getMyDayRankByGameType(param1:int) : int{return 0;}
      
      public function getDayMaxScoreByType(param1:int) : int{return 0;}
      
      public function getHisMaxScoreByType(param1:int) : int{return 0;}
   }
}
