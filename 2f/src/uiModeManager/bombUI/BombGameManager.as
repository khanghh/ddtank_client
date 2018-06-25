package uiModeManager.bombUI{   import ddt.data.player.SelfInfo;   import ddt.manager.PlayerManager;   import flash.display.MovieClip;   import funnyGames.cubeGame.CubeGameManager;   import road7th.data.DictionaryData;   import road7th.utils.StringHelper;   import uiModeManager.bombUI.model.bomb.BombGameModel;   import uiModeManager.bombUI.model.bomb.BombGameRandomMapAnalyzer;   import uiModeManager.bombUI.model.bomb.BombRankInfo;   import uiModeManager.bombUI.model.bomb.FixedMapData;   import uiModeManager.bombUI.model.bomb.RandomMapData;      public class BombGameManager   {                   private var bombPool:Array;            private var explode:MovieClip;            private var bullet:MovieClip;            private var _model:BombGameModel;            private var _fixedData:DictionaryData;            private var _randomData:DictionaryData;            public var currentGameLv:int = 1;            public var doubleScore:Boolean = false;            public function BombGameManager() { super(); }
            public function get model() : BombGameModel { return null; }
            public function clearBombData() : void { }
            public function initTotalRankData(info:BombRankInfo, type:int) : void { }
            public function clearRankDataByType(gameType:int) : void { }
            public function initDayRankData(info:BombRankInfo, type:int) : void { }
            public function FixedAnalyzer(data:BombGameFixedMapAnalyzer) : void { }
            public function RandomAnalyzer(data:BombGameRandomMapAnalyzer) : void { }
            public function get Fixeddata() : DictionaryData { return null; }
            public function get Randomdata() : DictionaryData { return null; }
            public function CurrentRandomMapinfos(lv:int) : Array { return null; }
            public function getRandomMapData(data:RandomMapData) : Array { return null; }
            private function PutElementInData(arr:Array, pos:Array, type:int, num:int) : void { }
            private function randRange(min:Number, max:Number) : Number { return 0; }
            public function GetRandomMapDataByLv(lv:int) : RandomMapData { return null; }
            public function CheckCurrentLvBound(lv:int) : Boolean { return false; }
            public function CurrentBombGameRankInfo(rankType:int) : Vector.<BombRankInfo> { return null; }
            public function GetFixedMapDataByLv(lv:int) : FixedMapData { return null; }
            public function GetCurrentBombMapData() : Array { return null; }
            public function CurrentFixedMapInfos(lv:int) : Array { return null; }
            private function getFixedMapData(data:FixedMapData) : Array { return null; }
            public function getMyTotalRankByGameType(type:int) : int { return 0; }
            public function getMyDayRankByGameType(type:int) : int { return 0; }
            public function getDayMaxScoreByType(type:int) : int { return 0; }
            public function getHisMaxScoreByType(type:int) : int { return 0; }
   }}