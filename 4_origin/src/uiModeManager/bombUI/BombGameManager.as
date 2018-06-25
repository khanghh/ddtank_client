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
      
      public function initTotalRankData(info:BombRankInfo, type:int) : void
      {
         if(type == 2)
         {
            model.rankTotalFixInfos.push(info);
         }
         else
         {
            model.rankTotalRandomInfos.push(info);
         }
      }
      
      public function clearRankDataByType(gameType:int) : void
      {
         var len:int = 0;
         var info:* = null;
         if(gameType == 2)
         {
            len = model.rankTotalFixInfos.length;
            while(len > 0)
            {
               info = model.rankTotalFixInfos.pop();
               info = null;
               len = model.rankTotalFixInfos.length;
            }
            len = model.rankDayFixInfos.length;
            while(len > 0)
            {
               info = model.rankDayFixInfos.pop();
               info = null;
               len = model.rankDayFixInfos.length;
            }
         }
         if(gameType == 1 || gameType == 3)
         {
            len = model.rankTotalRandomInfos.length;
            while(len > 0)
            {
               info = model.rankTotalRandomInfos.pop();
               info = null;
               len = model.rankTotalRandomInfos.length;
            }
            len = model.rankDayRandomInfos.length;
            while(len > 0)
            {
               info = model.rankDayRandomInfos.pop();
               info = null;
               len = model.rankDayRandomInfos.length;
            }
         }
      }
      
      public function initDayRankData(info:BombRankInfo, type:int) : void
      {
         if(type == 2)
         {
            model.rankDayFixInfos.push(info);
         }
         else
         {
            model.rankDayRandomInfos.push(info);
         }
      }
      
      public function FixedAnalyzer(data:BombGameFixedMapAnalyzer) : void
      {
         _fixedData = data.data;
      }
      
      public function RandomAnalyzer(data:BombGameRandomMapAnalyzer) : void
      {
         _randomData = data.data;
      }
      
      public function get Fixeddata() : DictionaryData
      {
         return _fixedData;
      }
      
      public function get Randomdata() : DictionaryData
      {
         return _randomData;
      }
      
      public function CurrentRandomMapinfos(lv:int) : Array
      {
         var arr:* = null;
         var data:RandomMapData = GetRandomMapDataByLv(lv);
         model.CurrentGameCanBeClickTimes = data.Number;
         return getRandomMapData(data);
      }
      
      public function getRandomMapData(data:RandomMapData) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var start:int = 0;
         var lenX:int = 0;
         var lenY:int = 0;
         var num:int = 0;
         var totle:int = 0;
         var pro:* = null;
         var a:* = 0;
         var b:* = 0;
         var posArr:* = null;
         var spaceNum:int = 0;
         var randomNum:int = 0;
         var arr:Array = [];
         if(data)
         {
            for(i = 0; i < 10; )
            {
               arr[i] = [];
               for(j = 0; j < 10; )
               {
                  arr[i][j] = 0;
                  j++;
               }
               i++;
            }
            start = (10 - data.XAxes) / 2;
            lenX = data.XAxes;
            lenY = data.Yaxes;
            totle = data.XAxes * data.Yaxes;
            a = 0;
            b = 0;
            posArr = [];
            for(a = start; a < start + lenX; )
            {
               for(b = start; b < start + lenY; )
               {
                  posArr.push([a,b]);
                  b++;
               }
               a++;
            }
            for(a = int(BombState.Bomb_1); a <= BombState.Bomb_Obs; )
            {
               pro = "Element" + a + "MinCount";
               if(data.hasOwnProperty(pro))
               {
                  num = num + data[pro];
                  if(num <= totle)
                  {
                     PutElementInData(arr,posArr,a,data[pro]);
                  }
                  else
                  {
                     trace("警告！！！！炸弹配的比格子多了");
                  }
               }
               a++;
            }
            spaceNum = randRange(data.Element0MinCount,data.Element0MaxCount) + data.Element0MinCount;
            num = totle - num - spaceNum;
            for(a = int(BombState.Bomb_Obs); a >= BombState.Bomb_1; )
            {
               pro = "Element" + a + "MaxCount";
               randomNum = randRange(data["Element" + a + "MinCount"],data[pro]);
               if(data.hasOwnProperty(pro) && randomNum > 0)
               {
                  if(num > randomNum)
                  {
                     num = num - randomNum;
                     PutElementInData(arr,posArr,a,randomNum);
                  }
                  else if(num > 0)
                  {
                     PutElementInData(arr,posArr,a,num);
                     break;
                  }
               }
               a--;
            }
         }
         return arr;
      }
      
      private function PutElementInData(arr:Array, pos:Array, type:int, num:int) : void
      {
         var len:int = 0;
         var index:int = 0;
         var _pos:* = null;
         while(num > 0)
         {
            len = pos.length;
            index = Math.floor(Math.random() * len);
            _pos = pos[index];
            arr[_pos[0]][_pos[1]] = type;
            pos.splice(index,1);
            num--;
         }
      }
      
      private function randRange(min:Number, max:Number) : Number
      {
         if(min == max)
         {
            return 0;
         }
         var randomNum:Number = Math.floor(Math.random() * (max - min)) + 1;
         return randomNum;
      }
      
      public function GetRandomMapDataByLv(lv:int) : RandomMapData
      {
         var data:* = null;
         var arr:* = null;
         var i:int = 0;
         if(_randomData.hasKey(lv))
         {
            data = _randomData[lv];
         }
         else
         {
            arr = _randomData.list;
            for(i = 0; i < arr.length; )
            {
               data = arr[i];
               if(lv > data.LevelMin && lv <= data.LevelMax)
               {
                  return data;
               }
               i++;
            }
         }
         return data;
      }
      
      public function CheckCurrentLvBound(lv:int) : Boolean
      {
         var arr:* = null;
         var data:* = null;
         var i:int = 0;
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            return _fixedData.hasKey(lv);
         }
         if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            arr = _randomData.list;
            for(i = 0; i < arr.length; )
            {
               data = arr[i];
               if(lv > data.LevelMin && lv <= data.LevelMax)
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
      
      public function CurrentBombGameRankInfo(rankType:int) : Vector.<BombRankInfo>
      {
         var data:* = undefined;
         if(HappyLittleGameManager.instance.currentGameType == 2)
         {
            if(rankType == 2)
            {
               data = model.rankDayFixInfos;
            }
            if(rankType == 1)
            {
               data = model.rankTotalFixInfos;
            }
         }
         else if(HappyLittleGameManager.instance.currentGameType == 1 || 3)
         {
            if(rankType == 2)
            {
               data = model.rankDayRandomInfos;
            }
            if(rankType == 1)
            {
               data = model.rankTotalRandomInfos;
            }
         }
         return data;
      }
      
      public function GetFixedMapDataByLv(lv:int) : FixedMapData
      {
         var data:* = null;
         if(_fixedData.hasKey(lv))
         {
            data = _fixedData[lv];
         }
         return data;
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
      
      public function CurrentFixedMapInfos(lv:int) : Array
      {
         var arrI:* = null;
         var arr:Array = [];
         if(_fixedData.hasKey(lv))
         {
            arr = getFixedMapData(_fixedData[lv]);
         }
         return arr;
      }
      
      private function getFixedMapData(data:FixedMapData) : Array
      {
         var temp:* = null;
         var i:int = 0;
         var j:int = 0;
         var arrI:* = null;
         var len:int = 0;
         var vx:int = 0;
         var vy:int = 0;
         var k:int = 0;
         var arr:Array = [];
         for(i = 0; i < data.XAxes; )
         {
            arr[i] = [];
            for(j = 0; j < data.Yaxes; )
            {
               arr[i][j] = [];
               j++;
            }
            i++;
         }
         temp = data.Map;
         model.CurrentGameCanBeClickTimes = data.Number;
         if(!StringHelper.isNullOrEmpty(temp))
         {
            arrI = temp.split(",");
            len = arrI.length;
            for(k = 0; k < len; )
            {
               if(arrI[k])
               {
                  vx = k / data.XAxes;
                  vy = k % data.Yaxes;
                  arr[vx][vy] = arrI[k];
               }
               k++;
            }
         }
         return arr;
      }
      
      public function getMyTotalRankByGameType(type:int) : int
      {
         var len:int = 0;
         var i:int = 0;
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(type == 2)
         {
            len = model.rankTotalFixInfos.length;
            i;
            while(i < len)
            {
               if(model.rankTotalFixInfos[i].nameDis == selfInfo.NickName)
               {
                  return model.rankTotalFixInfos[i].rank;
               }
               i++;
            }
         }
         i = 0;
         if(type == 1 || 3)
         {
            len = model.rankTotalRandomInfos.length;
            i;
            while(i < len)
            {
               if(model.rankTotalRandomInfos[i].nameDis == selfInfo.NickName)
               {
                  return model.rankTotalRandomInfos[i].rank;
               }
               i++;
            }
         }
         return 0;
      }
      
      public function getMyDayRankByGameType(type:int) : int
      {
         var len:int = 0;
         var i:int = 0;
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         if(type == 2)
         {
            len = model.rankDayFixInfos.length;
            i;
            while(i < len)
            {
               if(model.rankDayFixInfos[i].nameDis == selfInfo.NickName)
               {
                  return model.rankDayFixInfos[i].rank;
               }
               i++;
            }
         }
         i = 0;
         if(type == 1 || 3)
         {
            len = model.rankDayRandomInfos.length;
            i;
            while(i < len)
            {
               if(model.rankDayRandomInfos[i].nameDis == selfInfo.NickName)
               {
                  return model.rankDayRandomInfos[i].rank;
               }
               i++;
            }
         }
         return 0;
      }
      
      public function getDayMaxScoreByType(type:int) : int
      {
         if(type == 2)
         {
            return model.fixGameDayMaxScore;
         }
         if(type == 1)
         {
            return model.randomGameDayMaxScore;
         }
         if(type == 3)
         {
            return CubeGameManager.getInstance().gameInfo.dailyHighScore;
         }
         return 0;
      }
      
      public function getHisMaxScoreByType(type:int) : int
      {
         if(type == 2)
         {
            return model.fixGameHisMaxScore;
         }
         if(type == 1)
         {
            return model.randomGameHisMaxScore;
         }
         if(type == 3)
         {
            return CubeGameManager.getInstance().gameInfo.historyHgihScore;
         }
         return 0;
      }
   }
}
