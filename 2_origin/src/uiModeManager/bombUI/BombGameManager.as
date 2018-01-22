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
      
      public function BombGameManager()
      {
         super();
         _model = new BombGameModel();
      }
      
      public function get model() : BombGameModel
      {
         return _model;
      }
      
      public function clearBombData() : void
      {
         currentGameLv = 1;
         model.clearData();
      }
      
      public function initTotalRankData(param1:BombRankInfo, param2:int) : void
      {
         if(param2 == 2)
         {
            model.rankTotalFixInfos.push(param1);
         }
         else
         {
            model.rankTotalRandomInfos.push(param1);
         }
      }
      
      public function clearRankDataByType(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1 == 2)
         {
            _loc2_ = model.rankTotalFixInfos.length;
            while(_loc2_ > 0)
            {
               _loc3_ = model.rankTotalFixInfos.pop();
               _loc3_ = null;
               _loc2_ = model.rankTotalFixInfos.length;
            }
            _loc2_ = model.rankDayFixInfos.length;
            while(_loc2_ > 0)
            {
               _loc3_ = model.rankDayFixInfos.pop();
               _loc3_ = null;
               _loc2_ = model.rankDayFixInfos.length;
            }
         }
         if(param1 == 1 || param1 == 3)
         {
            _loc2_ = model.rankTotalRandomInfos.length;
            while(_loc2_ > 0)
            {
               _loc3_ = model.rankTotalRandomInfos.pop();
               _loc3_ = null;
               _loc2_ = model.rankTotalRandomInfos.length;
            }
            _loc2_ = model.rankDayRandomInfos.length;
            while(_loc2_ > 0)
            {
               _loc3_ = model.rankDayRandomInfos.pop();
               _loc3_ = null;
               _loc2_ = model.rankDayRandomInfos.length;
            }
         }
      }
      
      public function initDayRankData(param1:BombRankInfo, param2:int) : void
      {
         if(param2 == 2)
         {
            model.rankDayFixInfos.push(param1);
         }
         else
         {
            model.rankDayRandomInfos.push(param1);
         }
      }
      
      public function FixedAnalyzer(param1:BombGameFixedMapAnalyzer) : void
      {
         _fixedData = param1.data;
      }
      
      public function RandomAnalyzer(param1:BombGameRandomMapAnalyzer) : void
      {
         _randomData = param1.data;
      }
      
      public function get Fixeddata() : DictionaryData
      {
         return _fixedData;
      }
      
      public function get Randomdata() : DictionaryData
      {
         return _randomData;
      }
      
      public function CurrentRandomMapinfos(param1:int) : Array
      {
         var _loc2_:* = null;
         var _loc3_:RandomMapData = GetRandomMapDataByLv(param1);
         model.CurrentGameCanBeClickTimes = _loc3_.Number;
         return getRandomMapData(_loc3_);
      }
      
      public function getRandomMapData(param1:RandomMapData) : Array
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc13_:* = null;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         var _loc10_:* = null;
         var _loc15_:int = 0;
         var _loc14_:int = 0;
         var _loc4_:Array = [];
         if(param1)
         {
            _loc7_ = 0;
            while(_loc7_ < 10)
            {
               _loc4_[_loc7_] = [];
               _loc6_ = 0;
               while(_loc6_ < 10)
               {
                  _loc4_[_loc7_][_loc6_] = 0;
                  _loc6_++;
               }
               _loc7_++;
            }
            _loc11_ = (10 - param1.XAxes) / 2;
            _loc8_ = param1.XAxes;
            _loc12_ = param1.Yaxes;
            _loc2_ = param1.XAxes * param1.Yaxes;
            _loc5_ = 0;
            _loc3_ = 0;
            _loc10_ = [];
            _loc5_ = _loc11_;
            while(_loc5_ < _loc11_ + _loc8_)
            {
               _loc3_ = _loc11_;
               while(_loc3_ < _loc11_ + _loc12_)
               {
                  _loc10_.push([_loc5_,_loc3_]);
                  _loc3_++;
               }
               _loc5_++;
            }
            _loc5_ = int(BombState.Bomb_1);
            while(_loc5_ <= BombState.Bomb_Obs)
            {
               _loc13_ = "Element" + _loc5_ + "MinCount";
               if(param1.hasOwnProperty(_loc13_))
               {
                  _loc9_ = _loc9_ + param1[_loc13_];
                  if(_loc9_ <= _loc2_)
                  {
                     PutElementInData(_loc4_,_loc10_,_loc5_,param1[_loc13_]);
                  }
                  else
                  {
                     trace("警告！！！！炸弹配的比格子多了");
                  }
               }
               _loc5_++;
            }
            _loc15_ = randRange(param1.Element0MinCount,param1.Element0MaxCount) + param1.Element0MinCount;
            _loc9_ = _loc2_ - _loc9_ - _loc15_;
            _loc5_ = int(BombState.Bomb_Obs);
            while(_loc5_ >= BombState.Bomb_1)
            {
               _loc13_ = "Element" + _loc5_ + "MaxCount";
               _loc14_ = randRange(param1["Element" + _loc5_ + "MinCount"],param1[_loc13_]);
               if(param1.hasOwnProperty(_loc13_) && _loc14_ > 0)
               {
                  if(_loc9_ > _loc14_)
                  {
                     _loc9_ = _loc9_ - _loc14_;
                     PutElementInData(_loc4_,_loc10_,_loc5_,_loc14_);
                  }
                  else if(_loc9_ > 0)
                  {
                     PutElementInData(_loc4_,_loc10_,_loc5_,_loc9_);
                     break;
                  }
               }
               _loc5_--;
            }
         }
         return _loc4_;
      }
      
      private function PutElementInData(param1:Array, param2:Array, param3:int, param4:int) : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         while(param4 > 0)
         {
            _loc7_ = param2.length;
            _loc5_ = Math.floor(Math.random() * _loc7_);
            _loc6_ = param2[_loc5_];
            param1[_loc6_[0]][_loc6_[1]] = param3;
            param2.splice(_loc5_,1);
            param4--;
         }
      }
      
      private function randRange(param1:Number, param2:Number) : Number
      {
         if(param1 == param2)
         {
            return 0;
         }
         var _loc3_:Number = Math.floor(Math.random() * (param2 - param1)) + 1;
         return _loc3_;
      }
      
      public function GetRandomMapDataByLv(param1:int) : RandomMapData
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(_randomData.hasKey(param1))
         {
            _loc3_ = _randomData[param1];
         }
         else
         {
            _loc2_ = _randomData.list;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc4_];
               if(param1 > _loc3_.LevelMin && param1 <= _loc3_.LevelMax)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      public function CheckCurrentLvBound(param1:int) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            return _fixedData.hasKey(param1);
         }
         if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            _loc2_ = _randomData.list;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc4_];
               if(param1 > _loc3_.LevelMin && param1 <= _loc3_.LevelMax)
               {
                  return true;
               }
               _loc4_++;
            }
         }
         return false;
      }
      
      public function CurrentBombGameRankInfo(param1:int) : Vector.<BombRankInfo>
      {
         var _loc2_:* = undefined;
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            if(param1 == 2)
            {
               _loc2_ = model.rankDayFixInfos;
            }
            if(param1 == 1)
            {
               _loc2_ = model.rankTotalFixInfos;
            }
         }
         else if(HappyLittleGameManager.instance.currentGameType == 1 || 3)
         {
            if(param1 == 2)
            {
               _loc2_ = model.rankDayRandomInfos;
            }
            if(param1 == 1)
            {
               _loc2_ = model.rankTotalRandomInfos;
            }
         }
         return _loc2_;
      }
      
      public function GetFixedMapDataByLv(param1:int) : FixedMapData
      {
         var _loc2_:* = null;
         if(_fixedData.hasKey(param1))
         {
            _loc2_ = _fixedData[param1];
         }
         return _loc2_;
      }
      
      public function GetCurrentBombMapData() : Array
      {
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            model.BombTrain = CurrentFixedMapInfos(currentGameLv);
            return model.BombTrain;
         }
         if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            model.BombTrain = CurrentRandomMapinfos(currentGameLv);
            return model.BombTrain;
         }
         return model.BombTrain;
      }
      
      public function CurrentFixedMapInfos(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc2_:Array = [];
         if(_fixedData.hasKey(param1))
         {
            _loc2_ = getFixedMapData(_fixedData[param1]);
         }
         return _loc2_;
      }
      
      private function getFixedMapData(param1:FixedMapData) : Array
      {
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:Array = [];
         _loc10_ = 0;
         while(_loc10_ < param1.XAxes)
         {
            _loc4_[_loc10_] = [];
            _loc8_ = 0;
            while(_loc8_ < param1.Yaxes)
            {
               _loc4_[_loc10_][_loc8_] = [];
               _loc8_++;
            }
            _loc10_++;
         }
         _loc5_ = param1.Map;
         model.CurrentGameCanBeClickTimes = param1.Number;
         if(!StringHelper.isNullOrEmpty(_loc5_))
         {
            _loc7_ = _loc5_.split(",");
            _loc6_ = _loc7_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc6_)
            {
               if(_loc7_[_loc9_])
               {
                  _loc3_ = _loc9_ / param1.XAxes;
                  _loc2_ = _loc9_ % param1.Yaxes;
                  _loc4_[_loc3_][_loc2_] = _loc7_[_loc9_];
               }
               _loc9_++;
            }
         }
         return _loc4_;
      }
      
      public function getMyTotalRankByGameType(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         if(param1 == 2)
         {
            _loc3_ = model.rankTotalFixInfos.length;
            _loc4_;
            while(_loc4_ < _loc3_)
            {
               if(model.rankTotalFixInfos[_loc4_].nameDis == _loc2_.NickName)
               {
                  return model.rankTotalFixInfos[_loc4_].rank;
               }
               _loc4_++;
            }
         }
         _loc4_ = 0;
         if(param1 == 1 || 3)
         {
            _loc3_ = model.rankTotalRandomInfos.length;
            _loc4_;
            while(_loc4_ < _loc3_)
            {
               if(model.rankTotalRandomInfos[_loc4_].nameDis == _loc2_.NickName)
               {
                  return model.rankTotalRandomInfos[_loc4_].rank;
               }
               _loc4_++;
            }
         }
         return 0;
      }
      
      public function getMyDayRankByGameType(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         if(param1 == 2)
         {
            _loc3_ = model.rankDayFixInfos.length;
            _loc4_;
            while(_loc4_ < _loc3_)
            {
               if(model.rankDayFixInfos[_loc4_].nameDis == _loc2_.NickName)
               {
                  return model.rankDayFixInfos[_loc4_].rank;
               }
               _loc4_++;
            }
         }
         _loc4_ = 0;
         if(param1 == 1 || 3)
         {
            _loc3_ = model.rankDayRandomInfos.length;
            _loc4_;
            while(_loc4_ < _loc3_)
            {
               if(model.rankDayRandomInfos[_loc4_].nameDis == _loc2_.NickName)
               {
                  return model.rankDayRandomInfos[_loc4_].rank;
               }
               _loc4_++;
            }
         }
         return 0;
      }
      
      public function getDayMaxScoreByType(param1:int) : int
      {
         if(param1 == 2)
         {
            return model.fixGameDayMaxScore;
         }
         if(param1 == 1)
         {
            return model.randomGameDayMaxScore;
         }
         if(param1 == 3)
         {
            return CubeGameManager.getInstance().gameInfo.dailyHighScore;
         }
         return 0;
      }
      
      public function getHisMaxScoreByType(param1:int) : int
      {
         if(param1 == 2)
         {
            return model.fixGameHisMaxScore;
         }
         if(param1 == 1)
         {
            return model.randomGameHisMaxScore;
         }
         if(param1 == 3)
         {
            return CubeGameManager.getInstance().gameInfo.historyHgihScore;
         }
         return 0;
      }
   }
}
