package drgnBoat.views
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.data.DrgnBoatCarInfo;
   import drgnBoat.data.DrgnBoatPlayerInfo;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class DrgnBoatMapView extends Sprite implements Disposeable
   {
       
      
      private var _mapLayer:Sprite;
      
      private var _playerLayer:Sprite;
      
      private var _playerList:Vector.<DrgnBoatGamePlayer>;
      
      private var _selfPlayer:DrgnBoatGamePlayer;
      
      private var _itemList:DictionaryData;
      
      private var _playerItemList:Array;
      
      private var _rankArriveList:Array;
      
      private var _needRankList:DictionaryData;
      
      private var _isStartGame:Boolean = false;
      
      private var _mapBitmapData:BitmapData;
      
      private var _startMc:MovieClip;
      
      private var _endMc:MovieClip;
      
      private var _boguArr:Array;
      
      private var _finishTag:Bitmap;
      
      private var _runPercent:DrgnBoatRunPercent;
      
      private var _arriveCountDown:DrgnBoatArriveCountDown;
      
      private var _npcArriveTime:Date;
      
      private var _npcPlayer:DrgnBoatGamePlayer;
      
      private var _paopaoView:DrgnBoatNPCpaopao;
      
      private var _enterFrameCount:int = 0;
      
      private var _secondCount:int = 0;
      
      private var _beyondNPC:Boolean;
      
      private var _endFlag:Boolean = false;
      
      private var _isTween:Boolean = false;
      
      public function DrgnBoatMapView()
      {
         _itemList = new DictionaryData();
         _playerItemList = [];
         _rankArriveList = [];
         super();
         initView();
         initEvent();
      }
      
      public function set runPercent(value:DrgnBoatRunPercent) : void
      {
         _runPercent = value;
      }
      
      public function set arriveCountDown(value:DrgnBoatArriveCountDown) : void
      {
         _arriveCountDown = value;
      }
      
      private function initView() : void
      {
         initMapLayer();
         initPlayer();
      }
      
      private function initMapLayer() : void
      {
         var i:int = 0;
         var bitmap:* = null;
         var mc:* = null;
         _mapLayer = new Sprite();
         addChild(_mapLayer);
         _mapBitmapData = ComponentFactory.Instance.creatBitmapData("drgnBoat.mapBg");
         var count:int = Math.ceil(33600 / 1551);
         for(i = 0; i <= count; )
         {
            bitmap = new Bitmap(_mapBitmapData);
            bitmap.x = i * 1551;
            _mapLayer.addChild(bitmap);
            i++;
         }
         _startMc = ComponentFactory.Instance.creat("drgnBoat.StartEndTagMC");
         _startMc.gotoAndStop(1);
         _startMc.x = 280;
         _startMc.y = 174;
         _endMc = ComponentFactory.Instance.creat("drgnBoat.StartEndTagMC");
         _endMc.gotoAndStop(1);
         _endMc.x = 280 + 33600;
         _endMc.y = 174;
         _boguArr = [];
         for(i = 0; i <= 2; )
         {
            mc = ComponentFactory.Instance.creat("drgnBoat.bogu" + i);
            mc.gotoAndPlay(1);
            mc.x = 300 + i * 1000;
            mc.y = 120;
            _boguArr.push(mc);
            _mapLayer.addChild(mc);
            i++;
         }
         _mapLayer.addChild(_startMc);
         _mapLayer.addChild(_endMc);
      }
      
      private function initPlayer() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var tmpP:* = null;
         var totalTime:int = 0;
         var cha:int = 0;
         _playerLayer = new Sprite();
         addChild(_playerLayer);
         var playerInfoList:Vector.<DrgnBoatPlayerInfo> = DrgnBoatManager.instance.playerList;
         if(!playerInfoList)
         {
            return;
         }
         _playerList = new Vector.<DrgnBoatGamePlayer>();
         _needRankList = new DictionaryData();
         var len:int = playerInfoList.length;
         for(i = 0; i < len; )
         {
            tmp = playerInfoList[i];
            tmpP = new DrgnBoatGamePlayer(tmp);
            _playerLayer.addChild(tmpP);
            _playerList.push(tmpP);
            _playerItemList.push(tmpP);
            _needRankList.add(i.toString(),i);
            if(tmp.isSelf)
            {
               _selfPlayer = tmpP;
            }
            i++;
         }
         var info:DrgnBoatPlayerInfo = new DrgnBoatPlayerInfo();
         info.carType = 3;
         info.name = "巴罗夫";
         if(_npcArriveTime)
         {
            totalTime = ServerConfigManager.instance.dragonBoatFastTime * 1000;
            cha = _npcArriveTime.getTime() - TimeManager.Instance.Now().getTime();
            cha = cha > 0?cha:0;
            info.posX = 280 + 33600 - cha / totalTime * 33600;
         }
         _npcPlayer = new DrgnBoatGamePlayer(info);
         _playerLayer.addChild(_npcPlayer);
         _playerList.push(_npcPlayer);
         _playerItemList.push(_npcPlayer);
         _needRankList.add(i.toString(),i);
         playerItemDepth();
         refreshNeedRankList();
         setCenter(false);
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",updateMap,false,0,true);
         DrgnBoatManager.instance.addEventListener("drgnBoatMove",moveHandler);
         DrgnBoatManager.instance.addEventListener("drgnBoatAppearItem",refreshItemHandler);
         DrgnBoatManager.instance.addEventListener("drgnBoatRefreshBuff",refreshBuffHandler);
         DrgnBoatManager.instance.addEventListener("drgnBoatUseSkill",useSkillHandler);
         DrgnBoatManager.instance.addEventListener("launchMissile",playLaunchMcHandler);
         DrgnBoatManager.instance.addEventListener("drgnBoatReEnterAllInfo",createPlayerHandler);
         DrgnBoatManager.instance.addEventListener("drgnBoatFightStateChange",playerFightStateChangeHandler);
         DrgnBoatManager.instance.addEventListener("",rankArriveListChangeHandler);
      }
      
      private function rankArriveListChangeHandler(event:DrgnBoatEvent) : void
      {
         _rankArriveList = event.data as Array;
         refreshNeedRankList();
      }
      
      private function refreshNeedRankList() : void
      {
         if(!_playerList || !_rankArriveList)
         {
            return;
         }
         var needDelete:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _needRankList;
         for each(var tmp in _needRankList)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _rankArriveList;
            for each(var obj in _rankArriveList)
            {
               if(obj.id == _playerList[tmp].playerInfo.id && obj.zoneId == _playerList[tmp].playerInfo.zoneId)
               {
                  needDelete.push(tmp);
                  break;
               }
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = needDelete;
         for each(var tmp2 in needDelete)
         {
            _needRankList.remove(tmp2.toString());
         }
      }
      
      private function updateRankList() : void
      {
         var j:int = 0;
         if(!_playerList)
         {
            return;
         }
         var tmpPlayerList:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _needRankList;
         for each(var i in _needRankList)
         {
            tmpPlayerList.push(_playerList[i]);
         }
         tmpPlayerList.sortOn("x",16 | 2);
         var rankList:Array = [];
         var len:int = tmpPlayerList.length;
         for(j = 0; j < len; )
         {
            rankList.push({
               "name":tmpPlayerList[j].playerInfo.name,
               "carType":tmpPlayerList[j].playerInfo.carType,
               "isSelf":tmpPlayerList[j].playerInfo.isSelf
            });
            j++;
         }
         var tmpEvent:DrgnBoatEvent = new DrgnBoatEvent("drgnBoatRankList");
         tmpEvent.data = _rankArriveList.concat(rankList);
         DrgnBoatManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function playerFightStateChangeHandler(event:DrgnBoatEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               tmp.playerInfo.fightState = dataInfo.fightState;
               tmp.refreshFightMc();
               tmp.x = dataInfo.posX + 280;
               break;
            }
         }
      }
      
      private function createPlayerHandler(event:Event) : void
      {
         initPlayer();
      }
      
      private function useSkillHandler(event:DrgnBoatEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               if(dataInfo.sound)
               {
                  SoundManager.instance.play("escort04");
               }
               tmp.x = dataInfo.leapX + 280;
               break;
            }
         }
      }
      
      private function refreshBuffHandler(event:DrgnBoatEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               if(tmp.playerInfo.isSelf)
               {
                  if((dataInfo.acceleEndTime as Date).getTime() - tmp.playerInfo.acceleEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("escort01");
                  }
                  if((dataInfo.deceleEndTime as Date).getTime() - tmp.playerInfo.deceleEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("escort02");
                  }
                  else if((dataInfo.deceleEndTime as Date).getTime() - tmp.playerInfo.deceleEndTime.getTime() < -1000)
                  {
                     SoundManager.instance.play("escort05");
                  }
                  if((dataInfo.invisiEndTime as Date).getTime() - tmp.playerInfo.invisiEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("escort03");
                  }
                  if((dataInfo.missileEndTime as Date).getTime() - tmp.playerInfo.missileEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("087");
                  }
                  else if((dataInfo.missileEndTime as Date).getTime() - tmp.playerInfo.missileEndTime.getTime() < -1000)
                  {
                     SoundManager.instance.play("escort05");
                  }
               }
               tmp.playerInfo.acceleEndTime = dataInfo.acceleEndTime;
               tmp.playerInfo.deceleEndTime = dataInfo.deceleEndTime;
               tmp.playerInfo.invisiEndTime = dataInfo.invisiEndTime;
               tmp.playerInfo.missileEndTime = dataInfo.missileEndTime;
               tmp.playerInfo.missileHitEndTime = new Date(TimeManager.Instance.Now().getTime() + 1000);
               tmp.refreshBuffCountDown();
               break;
            }
         }
      }
      
      private function refreshItemHandler(event:DrgnBoatEvent) : void
      {
         var tmpItem:* = null;
         var tag:int = 0;
         var addItem:* = null;
         var itemData:Object = event.data;
         var tmpItemList:Array = itemData.itemList;
         var _loc9_:int = 0;
         var _loc8_:* = tmpItemList;
         for each(var obj in tmpItemList)
         {
            tmpItem = _itemList[obj.index];
            ObjectUtils.disposeObject(tmpItem);
            if(tmpItem)
            {
               _playerItemList.splice(_playerItemList.indexOf(tmpItem),1);
            }
            tag = obj.tag;
            if(tag == 0)
            {
               _itemList.remove(obj.index);
            }
            else
            {
               addItem = new DrgnBoatGameItem(obj.index,obj.type,obj.posX);
               _playerLayer.addChild(addItem);
               _itemList.add(obj.index,addItem);
               _playerItemList.push(addItem);
            }
         }
         playerItemDepth();
      }
      
      private function playerItemDepth() : void
      {
         var i:int = 0;
         _playerItemList.sortOn("y",16);
         var len:int = _playerItemList.length;
         for(i = 0; i < len; )
         {
            _playerLayer.addChild(_playerItemList[i]);
            i++;
         }
      }
      
      private function moveHandler(event:DrgnBoatEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               tmp.destinationX = dataInfo.destX;
               break;
            }
         }
      }
      
      private function updateMap(event:Event) : void
      {
         var mc:* = null;
         var carInfo:* = null;
         if(!_isStartGame)
         {
            return;
         }
         _enterFrameCount = Number(_enterFrameCount) + 1;
         if(_enterFrameCount > 25)
         {
            updateRankList();
            calibrateNpcPos();
            _enterFrameCount = 0;
            _secondCount = Number(_secondCount) + 1;
            if(_secondCount % 60 == 0)
            {
               if(!_beyondNPC && !_endFlag)
               {
                  npcChat(LanguageMgr.GetTranslation("drgnBoat.npc.beyond"),1);
               }
            }
         }
         if(_npcPlayer.x >= 280 + 33600)
         {
            if(!_endFlag)
            {
               if(_beyondNPC)
               {
                  npcChat(LanguageMgr.GetTranslation("drgnBoat.npc.loseEnd"),1);
               }
               else
               {
                  npcChat(LanguageMgr.GetTranslation("drgnBoat.npc.winEnd"),1);
               }
               _endFlag = true;
            }
         }
         else
         {
            _npcPlayer.x = _npcPlayer.x + DrgnBoatManager.instance.npcSpeed;
         }
         var flag:Boolean = false;
         var _loc7_:int = 0;
         var _loc6_:* = _playerList;
         for each(var tmp in _playerList)
         {
            tmp.updatePlayer();
            if(tmp.x > _npcPlayer.x)
            {
               flag = true;
            }
         }
         if(flag && !_beyondNPC && !_endFlag)
         {
            npcChat(LanguageMgr.GetTranslation("drgnBoat.npc.beyonded"));
         }
         _beyondNPC = flag;
         setCenter();
         if(_selfPlayer.x >= _boguArr[1].x)
         {
            mc = _boguArr.shift() as MovieClip;
            mc.x = mc.x + 3000;
            _boguArr.push(mc);
         }
         if(_selfPlayer && _arriveCountDown)
         {
            carInfo = DrgnBoatManager.instance.dataInfo.carInfo[_selfPlayer.playerInfo.carType];
            _arriveCountDown.refreshView(_selfPlayer.x,carInfo.speed);
         }
      }
      
      private function calibrateNpcPos() : void
      {
         var totalTime:int = ServerConfigManager.instance.dragonBoatFastTime * 1000;
         var cha:int = _npcArriveTime.getTime() - TimeManager.Instance.Now().getTime();
         cha = cha > 0?cha:0;
         var posX:int = 280 + 33600 - cha / totalTime * 33600;
         if(Math.abs(posX - _npcPlayer.x) >= 50)
         {
            _npcPlayer.x = posX;
         }
      }
      
      private function setCenter(isNeedTween:Boolean = true) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         if(_isTween)
         {
            return;
         }
         var xf:* = Number(350 - _selfPlayer.x);
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - _mapLayer.width)
         {
            xf = Number(1000 - _mapLayer.width);
         }
         var tmp:Number = Math.abs(x - xf);
         if(isNeedTween && tmp > 14)
         {
            TweenLite.to(this,tmp / 400 * 0.5,{
               "x":xf,
               "onComplete":tweenComplete
            });
            _isTween = true;
         }
         else
         {
            x = xf;
         }
      }
      
      private function tweenComplete() : void
      {
         _isTween = false;
      }
      
      public function startGame() : void
      {
         _isStartGame = true;
         var _loc3_:int = 0;
         var _loc2_:* = _playerList;
         for each(var tmp in _playerList)
         {
            tmp.startGame();
         }
      }
      
      public function endGame() : void
      {
         _isStartGame = false;
         var _loc3_:int = 0;
         var _loc2_:* = _playerList;
         for each(var tmp in _playerList)
         {
            tmp.endGame();
         }
      }
      
      private function playLaunchMcHandler(event:DrgnBoatEvent) : void
      {
         var timer:* = null;
         var obj:Object = event.data;
         var _loc6_:int = 0;
         var _loc5_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.id == obj.id && tmp.playerInfo.zoneId == obj.zoneId)
            {
               if(tmp.playerInfo.isSelf)
               {
                  timer = new Timer(2000,1);
                  timer.addEventListener("timerComplete",__launchTimerComplete);
                  timer.start();
               }
               tmp.playerInfo.missileLaunchEndTime = new Date(TimeManager.Instance.Now().getTime() + 2000);
               tmp.refreshBuffCountDown();
               break;
            }
         }
      }
      
      protected function __launchTimerComplete(event:TimerEvent) : void
      {
         var timer:Timer = event.target as Timer;
         timer.removeEventListener("timerComplete",__launchTimerComplete);
         timer.stop();
         var args:Array = DrgnBoatManager.instance.missileArgArr;
         SocketManager.Instance.out.sendEscortUseSkill(args[0],args[1],args[2],args[3],args[4]);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",updateMap);
         DrgnBoatManager.instance.removeEventListener("drgnBoatMove",moveHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatAppearItem",refreshItemHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatRefreshBuff",refreshBuffHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatUseSkill",useSkillHandler);
         DrgnBoatManager.instance.removeEventListener("launchMissile",playLaunchMcHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatReEnterAllInfo",createPlayerHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatFightStateChange",playerFightStateChangeHandler);
         DrgnBoatManager.instance.removeEventListener("",rankArriveListChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_startMc)
         {
            _startMc.gotoAndStop(2);
         }
         if(_endMc)
         {
            _endMc.gotoAndStop(2);
         }
         ObjectUtils.disposeObject(_npcPlayer);
         _npcPlayer = null;
         if(_paopaoView)
         {
            _paopaoView.removeEventListener("complete",__paopaoViewHide);
         }
         ObjectUtils.disposeObject(_paopaoView);
         _paopaoView = null;
         ObjectUtils.disposeAllChildren(_mapLayer);
         ObjectUtils.disposeAllChildren(_playerLayer);
         ObjectUtils.disposeAllChildren(this);
         _mapLayer = null;
         _playerLayer = null;
         _playerList = null;
         _selfPlayer = null;
         _itemList = null;
         _rankArriveList = null;
         if(_mapBitmapData)
         {
            _mapBitmapData.dispose();
         }
         _mapBitmapData = null;
         _runPercent = null;
         _startMc = null;
         _endMc = null;
         _finishTag = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selfPlayer() : DrgnBoatGamePlayer
      {
         return _selfPlayer;
      }
      
      public function set npcArriveTime(value:Date) : void
      {
         _npcArriveTime = value;
         var totalTime:int = ServerConfigManager.instance.dragonBoatFastTime * 1000;
         var cha:int = _npcArriveTime.getTime() - TimeManager.Instance.Now().getTime();
         cha = cha > 0?cha:0;
         _npcPlayer.x = 280 + 33600 - cha / totalTime * 33600;
      }
      
      public function npcChat(str:String, direction:int = 0) : void
      {
         if(_paopaoView)
         {
            _paopaoView.removeEventListener("complete",__paopaoViewHide);
         }
         ObjectUtils.disposeObject(_paopaoView);
         _paopaoView = null;
         _paopaoView = new DrgnBoatNPCpaopao(direction);
         _paopaoView.addEventListener("complete",__paopaoViewHide);
         _npcPlayer.addChild(_paopaoView);
         _paopaoView.setTxt(str);
      }
      
      protected function __paopaoViewHide(event:Event) : void
      {
         _paopaoView.removeEventListener("complete",__paopaoViewHide);
         ObjectUtils.disposeObject(_paopaoView);
         _paopaoView = null;
      }
   }
}
